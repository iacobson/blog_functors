defmodule HTTPoison.Response do
  defstruct [:body, :status_code]
end

defmodule HTTPoison.Error do
  defstruct [:reason]
end

defmodule Ecto.Changeset do
  defstruct [:changeset]
end
