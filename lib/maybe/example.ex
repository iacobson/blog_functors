defmodule Maybe.Example do
  import Maybe
  use FTPipe

  @doc """
  ### Examples:
      iex> Maybe.Example.capitalize_name_v1(%{name: "john"})
      "John"
  """
  def capitalize_name_v1(map) do
    map
    |> Map.get(:name)
    |> String.capitalize()
  end

  @doc """
  ### Examples:
      iex> Maybe.Example.capitalize_name_v2(%{name: "john"})
      "John"
      iex> Maybe.Example.capitalize_name_v2(%{age: 25})
      {:error, "name not available"}
      iex> Maybe.Example.capitalize_name_v2(nil)
      {:error, "name not available"}
  """
  def capitalize_name_v2(map) do
    map
    |> maybe_of()
    |> map(&Map.get(&1, :name))
    |> map(&String.capitalize/1)
    |> maybe(& &1, {:error, "name not available"})
  end

  @doc """
      iex> Maybe.Example.capitalize_name_v3(%{name: "john"})
      "John"
      iex> Maybe.Example.capitalize_name_v3(%{age: 25})
      {:error, nil}
      iex> Maybe.Example.capitalize_name_v3(nil)
      {:error, nil}
  """
  def capitalize_name_v3(map) do
    map
    ~>> Map.get(:name)
    ~>> String.capitalize()
  end
end
