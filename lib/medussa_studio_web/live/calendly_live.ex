defmodule MedussaStudioWeb.CalendlyLive do
  use MedussaStudioWeb, :live_view
  use Timex
  @week_start_at :mon

  @current_date Timex.now()

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        current_date: @current_date,
        day_names: day_names(@week_start_at),
        week_rows: week_rows(@current_date)
      )

    {:ok, socket}
  end

  def render(assigns) do
    MedussaStudioWeb.PageView.render("calendar.html", assigns)
  end

  defp day_names(:sun), do: [7, 1, 2, 3, 4, 5, 6] |> Enum.map(&Timex.day_shortname/1)
  defp day_names(_), do: [1, 2, 3, 4, 5, 6, 7] |> Enum.map(&Timex.day_shortname/1)

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
end
