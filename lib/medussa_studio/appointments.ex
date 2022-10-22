defmodule MedussaStudio.Appointments do
  @moduledoc """
  The Appointments context.
  """

  import Ecto.Query, warn: false
  alias MedussaStudio.Repo

  alias MedussaStudio.Appointments.Appointment

  def register_appointment(attrs) do
    IO.inspect(attrs, label: "attrs ---->")

    %Appointment{}
    |> Appointment.changeset(attrs)

    # |> Repo.insert()
  end

  def get_appointment!(id), do: Repo.get!(Appointment, id)
end
