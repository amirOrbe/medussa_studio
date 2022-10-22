defmodule MedussaStudioWeb.UserAppointmentLive do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  alias MedussaStudio.Repo
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

  def handle_event("save", %{"appointment" => appointment_attrs}, _socket) do
    IO.inspect(appointment_attrs, label: "appointment attrs -->")

    algo =
      appointment_attrs
      |> Enum.map(fn {key, value} -> {String.to_existing_atom(key), value} end)
      |> Map.new()
      |> Appointments.register_appointment()

    insert = Repo.insert!(algo)

    IO.inspect(insert, label: "insert --->")

    # case Appointments.register_appointment(appointment_attrs) do
    # algo -> IO.puts("si estuvo bien :D #{algo}")
    # error -> IO.puts("estuvo mal D: #{error}")
    # end
  end
end
