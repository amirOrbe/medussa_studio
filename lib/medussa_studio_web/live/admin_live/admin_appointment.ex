defmodule MedussaStudioWeb.AdminLive.AdminAppointment do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Utils.HandleJson
  alias MedussaStudio.Appointments

  def render(assigns) do
    ~H"""
    <div class="overflow-x-auto relative shadow-md sm:rounded-lg mt-10">
      <table class="w-full text-sm text-center text-gray-500 dark:text-gray-400">
      <thead class="text-xs text-white-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
      <tr>
        <th scope="col" class="py-3 px-6 bg-black text-white ">Fecha seleccionada</th>
        <th scope="col" class="py-3 px-6 bg-black text-white "><a href="#" class="hover:text-white">Servicio</a></th>
        <th scope="col" class="py-3 px-6 bg-black text-white "><a href="#" class="hover:text-white">Hora</a></th>
        <th scope="col" class="py-3 px-6 bg-black text-white "><a href="#" class="hover:text-white">Usuario</a></th>
        <th scope="col" class="py-3 px-6 bg-black text-white "><a href="#" class="hover:text-white">Estatus</a></th>
        <th scope="col" class="py-3 px-6 bg-black text-white ">Editar</th>
      </tr>
      </thead>
      <tbody>
        <%= for appointment <-  @appointments do %>
            <tr class="bg-white border-b dark:bg-gray-900 dark:text-white">
              <td class="py-4 px-6">
                <%= appointment.date %>
              </td>
              <td class="py-4 px-6">
              <%= appointment.service %>
              </td>
              <td class="py-4 px-6">
              <%= appointment.time %>
              </td>
              <td class="py-4 px-6">
              <%= appointment.user_id %>
              </td>
              <td class="py-4 px-6">
              <%= appointment.status %>
              </td>
              <td class="py-4 px-6">
              <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Editar</a>
              </td>
            </tr>
        <% end %>
      </tbody>
      </table>
    </div>
    """
  end

  defp list_of_appointments(%{date: date}) do
    Appointments.get_appointments_by_date(date)
  end

  def handle_info({:appointment_created, appointment}, socket) do
    {:noreply, update(socket, :appointments, fn appointments -> [appointment | appointments] end)}
  end

  def mount(params, session, socket) do
    if connected?(socket), do: Appointments.subscribe()

    socket =
      assign(socket,
        date: HandleJson.json_to_map(params),
        user_token: session["user_token"],
        appointments: list_of_appointments(HandleJson.json_to_map(params))
      )

    {:ok, socket}
  end
end
