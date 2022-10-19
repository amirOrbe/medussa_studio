defmodule MedussaStudioWeb.UserAppointmentLive do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  # alias MedussaStudio.Appointments.Appointment

  def mount(_, _, socket) do
    socket = assign(socket, %{changeset: Appointments.register_appointment(%{})})
    {:ok, socket}
  end

  def render(assigns) do
    MedussaStudioWeb.PageView.render("appointment.html", assigns)
  end

  # def handle_event("validate", %{"servicio" => params}, socket) do
  #   changeset =
  #     %Appointment{}
  #     |> Appointment.changeset(params)
  #     |> Map.put(:action, :insert)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  # def handle_event("save", %{"service" => service_params}, socket) do
  #   case Appointments.register_appointment(service_params) do
  #     {:ok, service} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "service created")
  #        |> redirect(
  #          to:
  #            Routes.user_path(
  #              MedussaStudioWeb.Endpoint,
  #              MedussaStudioWeb.UserAppointmentLive,
  #              service
  #            )
  #        )}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #   end
  # end
end
