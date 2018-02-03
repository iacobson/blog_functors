defmodule Example do
  use FTPipe

  @my_database %{btc: 10000, eth: 1000, ltc: 150}

  @doc """
  ### Examples:
      iex> Example.crypto("123")
      %{btc: 11000}
      iex> Example.crypto("1234")
      {:error, %Ecto.Changeset{changeset: %{btc: nil}}}
      iex> Example.crypto("456")
      {:error, "crypto currency not supported: xrp"}
      iex> Example.crypto("")
      {:error, "http error: closed"}
      iex> Example.crypto("wrong_key")
      {:error, "authorization error: unauthorized"}
  """

  def crypto(api_key) do
    api_key
    ~>> get_price()
    ~>> decode_response()
    ~>> update_price()
    ~>> send_to_frontend()
  end

  defp get_price("123") do
    # HTTPoison.get("crypto_url", params: %{api_key: "123"})
    {:ok, %HTTPoison.Response{body: %{crypto: :btc, price: 11000}, status_code: 200}}
  end

  defp get_price("1234") do
    {:ok, %HTTPoison.Response{body: %{crypto: :btc, price: nil}, status_code: 200}}
  end

  defp get_price("456") do
    {:ok, %HTTPoison.Response{body: %{crypto: :xrp, price: 11000}, status_code: 200}}
  end

  defp get_price("") do
    {:error, %HTTPoison.Error{reason: :closed}}
  end

  defp get_price(_) do
    {:ok, %HTTPoison.Response{body: "unauthorized", status_code: 401}}
  end

  defp decode_response({:ok, %{body: body}}) do
    # Poison decode
    body
  end

  defp update_price(%{crypto: crypto, price: nil}) do
    {:error, %Ecto.Changeset{changeset: %{crypto => nil}}}
  end

  defp update_price(%{crypto: crypto, price: price}) do
    case @my_database[crypto] do
      nil ->
        {:error, "crypto currency not supported: #{crypto}"}

      _ ->
        # save crypto in the database
        %{crypto => price}
    end
  end

  defp send_to_frontend(crypto) do
    case crypto do
      {:error, error} ->
        # log the error
        {:error, error}

      _ ->
        # send update to the front end
        crypto
    end
  end
end
