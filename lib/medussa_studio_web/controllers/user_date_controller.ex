defmodule MedussaStudioWeb.UserDateController do
  use MedussaStudioWeb, :controller

  def new(conn, params) do
    IO.inspect(params, label: "params -->")
    render(conn, "new.html", error_message: nil)
  end
end
