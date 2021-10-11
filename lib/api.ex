defmodule Api do
  @moduledoc """
  Api keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Api.Ledger.{
    AccountInstitutions,
    Accounts,
    Merchants,
    Transactions
  }

  defdelegate get_accounts(token), to: Accounts
  defdelegate get_account(token, account_id), to: Accounts
  defdelegate get_account_details(token, account_id), to: Accounts
  defdelegate get_account_balances(token, account_id), to: Accounts
  defdelegate get_account_institutions, to: AccountInstitutions

  defdelegate get_transactions(account_id), to: Transactions
  defdelegate get_transaction(account_id, transaction_id), to: Transactions

  defdelegate get_merchants, to: Merchants
  defdelegate get_merchant_categories, to: Merchants
end
