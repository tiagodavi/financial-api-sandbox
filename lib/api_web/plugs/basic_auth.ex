defmodule ApiWeb.Plugs.BasicAuth do
  @moduledoc """
  Functionality for providing Basic HTTP authentication.
  """
  import Plug.Conn

  alias Api.Utils
  alias Plug.BasicAuth

  @doc false
  def init(default), do: default

  @doc false
  def call(conn, _opts) do
    case BasicAuth.parse_basic_auth(conn) do
      {token, _pass} ->
        if is_token_valid?(conn, token),
          do: put_private(conn, :token, token),
          else: unauthorized(conn)

      _ ->
        unauthorized(conn)
    end
  end

  defp is_token_valid?(%Plug.Conn{params: %{"account_id" => account_id}}, token) do
    token_accounts = Utils.get_token_accounts()
    Map.get(token_accounts, token) == account_id
  end

  defp is_token_valid?(_conn, token) do
    valid_tokens = Utils.get_valid_tokens()
    token in valid_tokens
  end

  defp unauthorized(conn) do
    conn
    |> BasicAuth.request_basic_auth()
    |> halt()
  end
end
