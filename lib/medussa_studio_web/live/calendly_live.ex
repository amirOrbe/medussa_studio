defmodule MedussaStudioWeb.CalendlyLive do
  use MedussaStudioWeb, :live_view
  use Timex
  @week_start_at :mon

  @current_date Timex.now()
  # def mount(_params, _session, socket) do
  #   socket = assign(socket, :brightness, 10)
  #   {:ok, socket}
  # end

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
    # ~L"""
    # <div>
    # <div class="flex items-center mb-8">
    #     <div class="flex-1">
    #       <%= Timex.format!(Timex.now("America/Chicago"), "{Mshort} {YYYY}") %>
    #     </div>
    #   </div>
    # </div>
    # <h1>Holi</h1>
    # <%= @brightness %>
    # """
    #   <div>
    #   <a href="#" phx-click="prev-month" class="inline-block text-sm bg-white p-2 rounded shadow text-gray-600 border border-gray-200">&laquo; Prev</a>
    #   <a href="#" phx-click="next-month" class="inline-block text-sm bg-white p-2 rounded shadow text-gray-600 border border-gray-200">&raquo; Next</a>
    # </div>
    MedussaStudioWeb.PageView.render("calendar.html", assigns)
  end

  # defp day_names(:sun), do: [7, 1, 2, 3, 4, 5, 6] |> Enum.map(&Timex.day_shortname/1)
  defp day_names(_), do: [1, 2, 3, 4, 5, 6, 7] |> Enum.map(&Timex.day_shortname/1)

  defp week_rows(current_date) do
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
