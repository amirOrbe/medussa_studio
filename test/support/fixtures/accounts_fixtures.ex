defmodule MedussaStudio.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MedussaStudio.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        date_of_birth: ~D[2022-08-26],
        email: "some email",
        login_token: "some login_token",
        name: "some name",
        password: "some password",
        phone: 42
      })
      |> MedussaStudio.Accounts.create_user()

    user
  end
end
