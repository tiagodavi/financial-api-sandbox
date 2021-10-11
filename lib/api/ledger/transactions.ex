defmodule Api.Ledger.Transactions do
  @moduledoc """
    Transactions Context.
  """

  alias Api.Schemas.Transaction
  alias Api.Utils
  alias ApiWeb.Endpoint
  alias ApiWeb.Router.Helpers, as: Routes

  @spec get_transactions(Ecto.UUID.t()) :: list(Transaction.t())
  def get_transactions(account_id) do
    n_items = 90
    opening_balance = Money.new(1_000_000)
    {:ok, static_date} = Date.new(2021, 10, 7)
    static_date = Date.add(static_date, -n_items)
    last_five_merchants = Api.get_merchants() |> Enum.take(-5)
    last_five_merchant_categories = Api.get_merchant_categories() |> Enum.take(-5)
    [first_account_id | _] = Utils.get_valid_accounts()

    five_debits =
      if account_id == first_account_id do
        25_00..5_00//-5_00 |> Enum.to_list()
      else
        50_00..10_00//-10_00 |> Enum.to_list()
      end

    Enum.reduce(
      1..n_items,
      %{
        acc_merchants: last_five_merchants,
        acc_merchant_categories: last_five_merchant_categories,
        acc_debits: five_debits,
        acc_running_balance: Money.new(0),
        acc_transactions: []
      },
      fn index, acc ->
        date = Date.add(static_date, index)

        {debit, debits} = Utils.get_from_cycle(acc[:acc_debits], five_debits)

        {merchant, merchants} = Utils.get_from_cycle(acc[:acc_merchants], last_five_merchants)

        {merchant_category, merchant_categories} =
          Utils.get_from_cycle(acc[:acc_merchant_categories], last_five_merchant_categories)

        running_balance = Money.add(acc[:acc_running_balance], debit)
        opening_balance = Money.subtract(opening_balance, running_balance)
        transaction_id = UUID.uuid5(:oid, "transaction-#{account_id}-#{index}")

        {:ok, transaction} =
          Transaction.from_map(%{
            id: transaction_id,
            account_id: account_id,
            amount: -debit,
            date: date,
            description: merchant.name,
            details: %{
              id: merchant_category.id,
              category: merchant_category.name,
              processing_status: "complete",
              counterparty: %{
                id: merchant.id,
                name: merchant.counterparty,
                type: "organization"
              }
            },
            links: %{
              "account" => "#{Endpoint.url()}#{Routes.account_path(Endpoint, :show, account_id)}",
              "self" =>
                "#{Endpoint.url()}#{Routes.account_transaction_path(Endpoint, :show, account_id, transaction_id)}"
            },
            running_balance: opening_balance,
            status: "posted",
            type: "card_payment"
          })

        %{
          acc
          | acc_merchants: merchants,
            acc_merchant_categories: merchant_categories,
            acc_debits: debits,
            acc_running_balance: running_balance,
            acc_transactions: [transaction | acc[:acc_transactions]]
        }
      end
    )
    |> Map.get(:acc_transactions, [])
  end

  @spec get_transaction(Ecto.UUID.t(), Ecto.UUID.t()) :: Transaction.t() | nil
  def get_transaction(account_id, transaction_id) do
    transactions = get_transactions(account_id)
    Enum.find(transactions, &(&1.id == transaction_id))
  end
end
