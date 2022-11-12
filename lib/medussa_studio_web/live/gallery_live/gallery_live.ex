defmodule MedussaStudioWeb.GalleryLive.GalleryLive do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Gallery

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:current_id, Gallery.first_id())
      |> assign(:slideshow, :stopped)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="carouselExampleCaptions class="carousel slide relative" data-bs-ride="carousel">
    <div class="carousel-indicators absolute right-0 bottom-0 left-0 flex justify-center p-0 mb-4">
    <button
      type="button"
      data-bs-target="#carouselExampleCaptions"
      data-bs-slide-to="0"
      class="active"
      aria-current="true"
      aria-label="Slide 1"
    ></button>
    </div>
    <button phx-click="prev" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-l">
    Anterior
    </button>
    <button phx-click="next" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-r">
    Siguiente
    </button>
    </div>
      <%= if @slideshow == :stopped do %>
        <button phx-click="play_slideshow" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-r">Play</button>
      <% else %>
        <button phx-click="stop_slideshow" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-r">Stop</button>
      <% end %>
      <div class="carousel-inner relative w-full overflow-hidden">
      <div class="carousel-item active relative float-left w-full">
        <img src="<%= Gallery.large_url(@current_id) %>", class="block w-full">
      </div>
    </div>
    """
  end

  def handle_event("play_slideshow", _, socket) do
    {:ok, ref} = :timer.send_interval(1_000, self(), :slideshow_next)
    {:noreply, assign(socket, :slideshow, ref)}
  end

  def handle_event("stop_slideshow", _, socket) do
    :timer.cancel(socket.assigns.slideshow)
    {:noreply, assign(socket, :slideshow, :stopped)}
  end

  def handle_event("prev", _, socket) do
    {:noreply, assign_prev_id(socket)}
  end

  def handle_event("next", _, socket) do
    {:noreply, assign_next_id(socket)}
  end

  def handle_info(:slideshow_next, socket) do
    {:noreply, assign_next_id(socket)}
  end

  def assign_prev_id(socket) do
    assign(socket, :current_id, Gallery.prev_image_id(socket.assigns.current_id))
  end

  def assign_next_id(socket) do
    assign(socket, :current_id, Gallery.next_image_id(socket.assigns.current_id))
  end

  def thumb_css_class(thumb_id, current_id) do
    if thumb_id == current_id do
      "thumb-selected"
    else
      "thumb-unselected"
    end
  end
end
