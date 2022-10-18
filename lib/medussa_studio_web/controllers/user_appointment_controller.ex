defmodule MedussaStudioWeb.UserAppointmentController do
  use MedussaStudioWeb, :controller
  alias MedussaStudio.Appointments

  def new(conn, params) do
    changeset = Appointments.register_appointment(%{date: params})
    render(conn, "new.html", changeset: changeset)
  end
end
