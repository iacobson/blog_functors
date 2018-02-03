defmodule FTPipe do
  defmacro __using__(_) do
    quote do
      require unquote(__MODULE__)
      import unquote(__MODULE__)
    end
  end

  defmacro left ~>> right do
    quote do
      case unquote(left) do
        {:ok, %HTTPoison.Response{body: body, status_code: 401}} ->
          {:error, "authorization error: #{body}"}

        {:error, %HTTPoison.Error{reason: reason}} ->
          {:error, "http error: #{reason}"}

        nil ->
          {:error, nil}

        {:error, error} ->
          {:error, error}

        _ ->
          unquote(left) |> unquote(right)
      end
    end
  end
end
