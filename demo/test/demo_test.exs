defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test ".add adds two values" do
    assert Demo.add(2, 3) == 5
  end
end
