defmodule MedussaStudioWeb.AdminLive.AdminAppointment do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Utils.HandleJson
  alias MedussaStudio.Appointments

  def render(assigns) do
    ~H"""
    <table class="table-auto">
      <thead>
      <tr>
        <th>Fecha seleccionada</th>
        <th>Servicio</th>
        <th>Hora</th>
        <th>Usuario</th>
      </tr>
      </thead>
      <tbody>
        <%= for appointments <-  assigns.appointments do %>
          <%= for appointment <- appointments do %>
            <tr>
              <td>
                <%= appointment.date %>
              </td>
              <td>
              <%= appointment.service %>
              </td>
              <td>
              <%= appointment.time %>
              </td>
              <td>
              <%= appointment.user_id %>
              </td>
            </tr>
          <% end %>
        <% end %>
      </tbody>
    </table>
    """
  end

  defp list_of_appointments(date) do
    date
    |> Enum.map(fn {_key, date} -> Appointments.get_appointments_by_date(date) end)
  end

  def mount(params, session, socket) do
    socket =
      assign(socket,
        date: HandleJson.json_to_map(params),
        user_token: session["user_token"],
        appointments: list_of_appointments(HandleJson.json_to_map(params))
      )

    {:ok, socket}
  end
end
