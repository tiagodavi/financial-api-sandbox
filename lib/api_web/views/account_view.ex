defmodule ApiWeb.AccountView do
  use ApiWeb, :view

  def render("accounts.json", %{accounts: accounts}) do
    render_many(accounts, __MODULE__, "account.json")
  end

  def render("account.json", %{account: account}) do
    account
  end
end
