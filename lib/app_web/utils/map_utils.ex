defmodule AppWeb.Utils.MapUtils do
  @moduledoc """
  Utilities for working with maps
  """

  @doc """
  changes all keys of map to camel case  

  ## Parameters

  * `map` - The map you would like converted to camel case
  """
  def camelize(map) do
    Enum.map(map, fn {k, v} -> {Inflex.camelize(k, :lower), v} end)
  end
end
