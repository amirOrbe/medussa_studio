defmodule MedussaStudio.Utils.HandleJson do
  @moduledoc """
  Implements Utils.HandleJson behaviour
  Parses json to map.
  """

  def json_to_map(params) do
    params
    |> Enum.map(fn {key, value} -> {String.to_existing_atom(key), value} end)
    |> Map.new()
  end
end
