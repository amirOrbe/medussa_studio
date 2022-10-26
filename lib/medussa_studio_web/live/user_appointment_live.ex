defmodule MedussaStudioWeb.UserAppointmentLive do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  alias MedussaStudio.Repo
  # alias MedussaStudio.Appointments.Appointment

  def mount(params, _, socket) do
    socket =
      assign(socket,
        changeset: Appointments.validate_appointment(%{}),
        date: Enum.map(params, fn {_key, value} -> value end)
      )

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

  def handle_event("save", %{"appointment" => appointment_attrs}, socket) do
    appointment_changeset =
      appointment_attrs
      |> Enum.map(fn {key, value} -> {String.to_existing_atom(key), value} end)
      |> Map.new()
      |> Appointments.validate_appointment()

    Repo.insert(appointment_changeset)
    {:noreply, socket}
  end
end
