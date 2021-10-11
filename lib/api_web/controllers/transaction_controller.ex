defmodule ApiWeb.TransactionController do
  use ApiWeb, :controller

  def index(%{private: %{version: _version}} = conn, %{"account_id" => account_id}) do
    render(conn, "transactions.json", transactions: Api.get_transactions(account_id))
  end

  def show(%{private: %{version: _version}} = conn, %{
        "account_id" => account_id,
        "id" => transaction_id
      }) do
    transaction = Api.get_transaction(account_id, transaction_id)

    if transaction do
      render(conn, "transaction.json", transaction: transaction)
    else
      conn
      |> send_resp(404, "Not found")
      |> halt()
    end
  end
end
