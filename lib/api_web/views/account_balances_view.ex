defmodule ApiWeb.AccountBalancesView do
  use ApiWeb, :view

  def render("account_balances.json", %{account_balances: account_balances}) do
    account_balances
  end
end
