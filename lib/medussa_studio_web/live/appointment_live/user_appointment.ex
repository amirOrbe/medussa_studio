defmodule MedussaStudioWeb.AppointmentLive.UserAppointment do
  @moduledoc """
  Live view for create appointment
  """
  use MedussaStudioWeb, :live_view
  alias MedussaStudio.Appointments
  alias MedussaStudio.Accounts
  alias MedussaStudio.Utils.HandleJson
  @status "Espera"

  @impl true
  def mount(params, session, socket) do
    socket =
      assign(socket,
        changeset: Appointments.validate_appointment(%{}),
        date: HandleJson.json_to_map(params),
        user_token: session["user_token"]
      )

    {:ok, socket}
  end

  @impl true
  def handle_event("save", %{"appointment" => appointment_attrs}, socket) do
    date = Enum.into(socket.assigns.date, %{})
    user = Accounts.get_user_by_session_token(socket.assigns.user_token)

    if user do
      create_appointment(user, appointment_attrs, date, socket)
    else
      socket
      |> put_flash(:info, "Error, usuario no encontrado")
      |> redirect(to: "/")
    end
  end

  defp create_appointment(user, appointment_attrs, date, socket) do
    appointment =
      appointment_attrs
      |> HandleJson.json_to_map()
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
end
