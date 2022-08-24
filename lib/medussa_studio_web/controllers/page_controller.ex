defmodule MedussaStudioWeb.PageController do
  use MedussaStudioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
