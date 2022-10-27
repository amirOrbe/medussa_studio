defmodule MedussaStudioWeb.AppointmentLive.UserAppointment do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  alias MedussaStudio.Repo
  # alias MedussaStudio.Appointments.Appointment

  def mount(params, _, socket) do
    socket =
      assign(socket,
        changeset: Appointments.validate_appointment(%{}),
        date: correct_map_structure(params)
      )

    {:ok, socket}
  end

  # def handle_event("validate", %{"servicio" => params}, socket) do
  #   changeset =
  #     %Appointment{}
  #     |> Appointment.changeset(params)
  #     |> Map.put(:action, :insert)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  def handle_event("save", %{"appointment" => appointment_attrs}, socket) do
    date = Enum.into(socket.assigns.date, %{})

    appointment_changeset =
      appointment_attrs
      |> correct_map_structure()
      |> Map.new()
      |> Map.merge(date)
      |> Appointments.validate_appointment()

    Repo.insert(appointment_changeset)
    {:noreply, socket}
  end

  def correct_map_structure(params) do
    Enum.map(params, fn {key, value} -> {String.to_existing_atom(key), value} end)
  end
end
