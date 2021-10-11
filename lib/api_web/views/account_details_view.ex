defmodule ApiWeb.AccountDetailsView do
  use ApiWeb, :view

  def render("account_details.json", %{account_details: account_details}) do
    account_details
  end
end
