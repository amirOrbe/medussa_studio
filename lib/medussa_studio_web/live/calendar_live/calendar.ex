defmodule MedussaStudioWeb.CalendarLive.Calendar do
  @moduledoc """
  Module for the calendar logic
  """
  use MedussaStudioWeb, :live_view
  use Timex
  alias MedussaStudio.{Appointments, Accounts}

  @week_start_at :mon

  def mount(_params, session, socket) do
    if connected?(socket), do: Appointments.subscribe("notification")
    current_date = Timex.now()
    %{admin: admin} = Accounts.get_user_by_session_token(session["user_token"])

    socket =
      assign(socket,
        current_date: current_date,
        day_names: day_names(),
        week_rows: week_rows(current_date),
        user_admin: admin
      )

    {:ok, socket}
  end

  defp day_names,
    do:
      [1, 2, 3, 4, 5, 6, 7]
      |> Enum.map(&Timex.day_name/1)
      |> Enum.map(fn day -> Timex.Translator.translate("es", "weekdays", day) end)

  def week_rows(current_date) do
    first =
      current_date
      |> Timex.beginning_of_month()
      |> Timex.beginning_of_week(@week_start_at)

    last =
      current_date
      |> Timex.end_of_month()
      |> Timex.end_of_week(@week_start_at)

    Interval.new(from: first, until: last)
    |> Enum.map(& &1)
    |> Enum.chunk_every(7)
  end

  def handle_event("prev-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: -1)

    assigns = [
      current_date: current_date,
      week_rows: week_rows(current_date)
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("next-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: 1)

    assigns = [
      current_date: current_date,
      week_rows: week_rows(current_date)
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_info({:notification, appointment}, socket) do
    {:noreply,
     push_event(socket, "notification", %{
       title: "Medussa Studio",
       message: "Se creo una cita con la fecha: #{appointment.date} y hora #{appointment.time}"
     })}
  end
end
