defmodule MedussaStudioWeb.UserDateController do
  use MedussaStudioWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end
end
