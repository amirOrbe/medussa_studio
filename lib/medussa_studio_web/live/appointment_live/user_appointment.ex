defmodule MedussaStudioWeb.AppointmentLive.UserAppointment do
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  alias MedussaStudio.Accounts
  @status "Espera"

  def mount(params, session, socket) do
    socket =
      assign(socket,
        changeset: Appointments.validate_appointment(%{}),
        date: json_to_map(params),
        user_token: session["user_token"]
      )

    {:ok, socket}
  end

  def handle_event("save", %{"appointment" => appointment_attrs}, socket) do
    date = Enum.into(socket.assigns.date, %{})
    user = Accounts.get_user_by_session_token(socket.assigns.user_token)

    appointment =
      appointment_attrs
      |> json_to_map()
      |> Map.merge(date)
      |> Map.merge(%{status: @status})
      |> Map.merge(%{user_id: user.id})

    case Appointments.save_appointment(appointment) do
      {:ok, _appointment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cita creada")
         |> redirect(to: "/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def json_to_map(params) do
    params
    |> Enum.map(fn {key, value} -> {String.to_existing_atom(key), value} end)
    |> Map.new()
  end
end
