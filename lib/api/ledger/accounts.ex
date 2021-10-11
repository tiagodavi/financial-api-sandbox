defmodule Api.Ledger.Accounts do
  @moduledoc """
    Accounts Context.
  """

  alias Api.Schemas.{
    Account,
    AccountBalances,
    AccountDetails
  }

  alias Api.Utils
  alias ApiWeb.Endpoint
  alias ApiWeb.Router.Helpers, as: Routes

  @last_four [3886, 8684]

  @spec get_accounts(String.t()) :: list(Account.t())
  def get_accounts(token) do
    n_items = 2
    all_account_institutions = Api.get_account_institutions()
    all_account_names = get_account_names()

    Enum.reduce(
      1..n_items,
      %{
        acc_account_names: all_account_names,
        acc_account_institutions: all_account_institutions,
        acc_accounts: %{}
      },
      fn index, acc ->
        token = "test_#{UUID.uuid5(:oid, "account-#{index}", :slug)}"
        account_id = UUID.uuid5(:oid, "account-#{index}")

        {account_institution, account_institutions} =
          Utils.get_from_cycle(acc[:acc_account_institutions], all_account_institutions)

        {account_name, account_names} =
          Utils.get_from_cycle(acc[:acc_account_names], all_account_names)

        {:ok, account} =
          Account.from_map(%{
            id: account_id,
            enrollment_id: UUID.uuid5(:oid, "account-enrollment-#{index}"),
            last_four: Enum.at(@last_four, index - 1, 8684),
            name: account_name,
            institution: %{
              id: account_institution.id,
              name: account_institution.name
            },
            links: %{
              "self" => "#{Endpoint.url()}#{Routes.account_path(Endpoint, :show, account_id)}",
              "balances" =>
                "#{Endpoint.url()}#{Routes.account_balances_path(Endpoint, :index, account_id)}",
              "details" =>
                "#{Endpoint.url()}#{Routes.account_details_path(Endpoint, :index, account_id)}",
              "transactions" =>
                "#{Endpoint.url()}#{Routes.account_transaction_path(Endpoint, :index, account_id)}"
            }
          })

        %{
          acc
          | acc_account_names: account_names,
            acc_account_institutions: account_institutions,
            acc_accounts: Map.put(acc[:acc_accounts], token, [account])
        }
      end
    )
    |> Map.get(:acc_accounts, %{})
    |> Map.get(token, [])
  end

  @spec get_account(String.t(), Ecto.UUID.t()) :: Account.t() | nil
  def get_account(token, account_id) do
    accounts = get_accounts(token)
    Enum.find(accounts, &(&1.id == account_id))
  end

  @spec get_account_details(String.t(), Ecto.UUID.t()) :: AccountDetail.t() | nil
  def get_account_details(token, account_id) do
    with %Account{} = account <- get_account(token, account_id),
         {:ok, %AccountDetails{} = account_details} <- build_account_details(account) do
      account_details
    else
      _ -> nil
    end
  end

  @spec get_account_balances(String.t(), Ecto.UUID.t()) :: AccountBalances.t() | nil
  def get_account_balances(token, account_id) do
    with %Account{} = account <- get_account(token, account_id),
         {:ok, %AccountBalances{} = account_balances} <- build_account_balances(account) do
      account_balances
    else
      _ -> nil
    end
  end

  defp build_account_balances(%Account{} = account) do
    opening_balance = Money.new(1_000_000)

    transactions =
      account.id
      |> Api.get_transactions()
      |> Enum.reduce(Money.new(0), fn transaction, acc ->
        Money.add(acc, transaction.amount)
      end)

    available = Money.add(opening_balance, transactions)

    AccountBalances.from_map(%{
      account_id: account.id,
      available: available,
      ledger: available,
      links: %{
        "account" => "#{Endpoint.url()}#{Routes.account_path(Endpoint, :show, account.id)}",
        "self" => "#{Endpoint.url()}#{Routes.account_balances_path(Endpoint, :index, account.id)}"
      }
    })
  end

  defp build_account_details(%Account{} = account) do
    AccountDetails.from_map(%{
      account_id: account.id,
      account_number: "89182433#{account.last_four}",
      links: %{
        "account" => "#{Endpoint.url()}#{Routes.account_path(Endpoint, :show, account.id)}",
        "self" => "#{Endpoint.url()}#{Routes.account_details_path(Endpoint, :index, account.id)}"
      },
      routing_numbers: %{
        "ach" => "58155#{account.last_four}"
      }
    })
  end

  defp get_account_names do
    [
      "My Checking",
      "Jimmy Carter",
      "Ronald Reagan",
      "George H. W. Bush",
      "Bill Clinton",
      "George W. Bush",
      "Barack Obama",
      "Donald Trump"
    ]
  end
end
