defmodule MedussaStudioWeb.CalendlyLive do
  use MedussaStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Holi</h1>
    <%= @brightness %>
    """
  end
end
