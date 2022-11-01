defmodule MedussaStudio.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(date time service)a

  schema "appointment" do
    field :date, :string
    field :service, :string
    field :status, Ecto.Enum, values: [:Aceptado, :Rechazado, :Espera]
    field :time, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
