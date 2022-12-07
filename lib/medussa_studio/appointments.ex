defmodule MedussaStudio.Appointments do
  @moduledoc """
  The Appointments context.
  """

  import Ecto.Query, warn: false
  alias MedussaStudio.Repo

  alias MedussaStudio.Appointments.Appointment

  def validate_appointment(attrs) do
    Appointment.changeset(%Appointment{}, attrs)
  end

  def save_appointment(attrs) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:appointment_created)
    |> broadcast(:notification)
  end

  def get_appointmen_by_id!(id), do: Repo.get!(Appointment, id)

  def get_appointments_by_date(date) do
    Appointment
    |> where(date: ^date)
    |> Repo.all()
  end

  def subscribe("appointment" = appointment) do
    Phoenix.PubSub.subscribe(MedussaStudio.PubSub, appointment)
  end

  def subscribe("notification" = notification) do
    Phoenix.PubSub.subscribe(MedussaStudio.PubSub, notification)
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, appointment}, :appointment_created = event) do
    Phoenix.PubSub.broadcast(MedussaStudio.PubSub, "appointment", {event, appointment})
    {:ok, appointment}
  end

  defp broadcast({:ok, appointment}, :notification = event) do
    Phoenix.PubSub.broadcast(MedussaStudio.PubSub, "notification", {event, appointment})
    {:ok, appointment}
  end
end
