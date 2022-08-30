defmodule MedussaStudio.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  @user_attrs ~w(age date_of_birth email name password login_token phone)a

  schema "users" do
    field :age, :integer
    field :date_of_birth, :date
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
    |> cast(attrs, @user_attrs)
    |> validate_required(@user_attrs)
  end
end
