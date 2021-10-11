defmodule ApiWeb.AccountController do
  use ApiWeb, :controller

  def index(%{private: %{version: _version, token: token}} = conn, _params) do
    render(conn, "accounts.json", accounts: Api.get_accounts(token))
  end

  def show(%{private: %{version: _version, token: token}} = conn, %{"id" => account_id}) do
    account = Api.get_account(token, account_id)

    if account do
      render(conn, "account.json", account: account)
    else
      conn
      |> send_resp(404, "Not found")
      |> halt()
    end
  end
end
