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
  end

  def get_appointmen_by_idt!(id), do: Repo.get!(Appointment, id)

  def get_appointments_by_date(date) do
    Appointment
    |> where(date: ^date)
    |> Repo.all()
  end
end
