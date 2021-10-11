defmodule Api.Ledger.TransactionsTest do
  use Api.DataCase, async: true

  alias Api.Ledger.Transactions
  alias Api.Utils
  alias ApiWeb.Endpoint

  alias Api.Schemas.{
    Transaction,
    TransactionCounterParty,
    TransactionDetail
  }

  describe "&get_transactions/1" do
    test "should return a list of transactions" do
      [account_id | _] = Utils.get_valid_accounts()

      assert [
               %Transaction{id: t_1_id} = transaction_1,
               %Transaction{id: t_2_id} = transaction_2
               | _
             ] = Transactions.get_transactions(account_id)

      account_link = "#{Endpoint.url()}/accounts/#{account_id}"
      t_1_self_link = "#{account_link}/transactions/#{t_1_id}"
      t_2_self_link = "#{account_link}/transactions/#{t_2_id}"

      assert %Transaction{
               account_id: ^account_id,
               amount: %Money{amount: -500, currency: :USD},
               date: ~D[2021-10-07],
               description: "Walmart",
               details: %TransactionDetail{
                 category: "utilities",
                 counterparty: %TransactionCounterParty{
                   id: "6147948f-0fea-4559-9b92-f76640ae1b46",
                   name: "WALMART",
                   type: "organization"
                 },
                 id: "40c8a246-785c-49a2-8e84-7dd9d2db938c",
                 processing_status: "complete"
               },
               id: ^t_1_id,
               links: %{
                 "account" => ^account_link,
                 "self" => ^t_1_self_link
               },
               running_balance: %Money{amount: 865_000, currency: :USD},
               status: "posted",
               type: "card_payment"
             } = transaction_1

      assert %Transaction{
               account_id: ^account_id,
               amount: %Money{amount: -1000, currency: :USD},
               date: ~D[2021-10-06],
               description: "Apple",
               details: %TransactionDetail{
                 category: "software",
                 counterparty: %TransactionCounterParty{
                   id: "07fac0a1-38ff-48fa-b7cd-5a3a8dff31e4",
                   name: "APPLE",
                   type: "organization"
                 },
                 id: "54aeb81f-811f-4a6e-b388-5e66677a4596",
                 processing_status: "complete"
               },
               id: ^t_2_id,
               links: %{
                 "account" => ^account_link,
                 "self" => ^t_2_self_link
               },
               running_balance: %Money{amount: 865_500, currency: :USD},
               status: "posted",
               type: "card_payment"
             } = transaction_2
    end
  end
end
