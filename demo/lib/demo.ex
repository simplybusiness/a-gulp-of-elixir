defmodule Demo do
  @moduledoc """
  This module purpose is presentation only.
  """

  @doc """
  This function performs addition of two values.

  ## Examples

      iex> Demo.add(5, 1)
      6

      iex> result = Demo.add(1, 1)
      ...> Demo.add(result, 2)
      4
  """
  def add(a, b) do
    Enum.map(list, &($1 * 2))
    a + b
  end
end
