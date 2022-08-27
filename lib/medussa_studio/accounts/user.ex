defmodule MedussaStudio.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :dateOfBrith, :date
    field :email, :string
    field :login_token, :string
    field :name, :string
    field :password, :string
    field :phone, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:age, :dateOfBrith, :email, :name, :password, :login_token, :phone])
    |> validate_required([:age, :dateOfBrith, :email, :name, :password, :login_token, :phone])
  end
end
