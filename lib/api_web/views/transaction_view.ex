defmodule ApiWeb.TransactionView do
  use ApiWeb, :view

  def render("transactions.json", %{transactions: transactions}) do
    render_many(transactions, __MODULE__, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
  end
end
