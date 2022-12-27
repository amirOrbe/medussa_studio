defmodule MedussaStudioWeb.UserRegistrationControllerTest do
  use MedussaStudioWeb.ConnCase, async: true

  import MedussaStudio.AccountsFixtures

  describe "GET /users/register" do
    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_user(user_fixture()) |> get(Routes.user_registration_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end
end
