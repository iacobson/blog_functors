defmodule Maybe do
  @enforce_keys [:value]
  defstruct [:value]

  def maybe_of(value) do
    %Maybe{value: value}
  end

  def map(%Maybe{value: nil} = maybe, _function) do
    maybe
  end

  def map(%Maybe{value: value}, function) do
    maybe_of(function.(value))
  end

  def maybe(%Maybe{value: nil}, _function, default) do
    default
  end

  def maybe(%Maybe{value: value}, function, _defatult) do
    function.(value)
  end
end
