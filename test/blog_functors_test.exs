defmodule FunctorsTest do
  use ExUnit.Case
  doctest Functors

  test "greets the world" do
    assert Functors.hello() == :world
  end
end
