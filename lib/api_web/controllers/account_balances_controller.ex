defmodule ApiWeb.AccountBalancesController do
  use ApiWeb, :controller

  def index(%{private: %{version: _version, token: token}} = conn, %{"account_id" => account_id}) do
    account_balances = Api.get_account_balances(token, account_id)

    if account_balances do
      render(conn, "account_balances.json", account_balances: account_balances)
    else
      conn
      |> send_resp(404, "Not found")
      |> halt()
    end
  end
end
