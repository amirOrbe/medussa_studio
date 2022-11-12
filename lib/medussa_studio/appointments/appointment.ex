defmodule MedussaStudio.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(date time service status user_id)a

  schema "appointment" do
    field :date, :string
    field :service, :string
    field :status, :string
    field :time, :string
    belongs_to :user, MedussaStudio.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
