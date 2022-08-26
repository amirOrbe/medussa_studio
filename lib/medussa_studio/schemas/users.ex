defmodule MedussaStudio.Schemas.Users do
  @moduledoc """
  Schema for users
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :dateOfBirth, :date
    field :email, :string
    field :name, :string
    field :password, :string
    field :phone, :integer

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:name, :email, :dateOfBirth, :password, :age, :phone])
    |> validate_required([:name, :email, :dateOfBirth, :password, :age, :phone])
  end
end
