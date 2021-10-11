defmodule ApiWeb.AccountDetailsController do
  use ApiWeb, :controller

  def index(%{private: %{version: _version, token: token}} = conn, %{"account_id" => account_id}) do
    account_details = Api.get_account_details(token, account_id)

    if account_details do
      render(conn, "account_details.json", account_details: account_details)
    else
      conn
      |> send_resp(404, "Not found")
      |> halt()
    end
  end
end
