defmodule MedussaStudioWeb.CalendlyLive do
  use MedussaStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div>
    <div class="flex items-center mb-8">
        <div class="flex-1">
          <%= Timex.format!(Timex.now("America/Chicago"), "{Mshort} {YYYY}") %>
        </div>
      </div>
    </div>
    <h1>Holi</h1>
    <%= @brightness %>
    """
  end
end
