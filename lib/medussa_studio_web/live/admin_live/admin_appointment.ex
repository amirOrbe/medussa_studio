defmodule MedussaStudioWeb.AdminLive.AdminAppointment do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Utils.HandleJson

  def mount(params, session, socket) do
    socket =
      assign(socket,
        date: HandleJson.json_to_map(params),
        user_token: session["user_token"]
      )

    {:ok, socket}
  end
end
