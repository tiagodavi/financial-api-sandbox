defmodule Api.Ledger.AccountsTest do
  use Api.DataCase, async: true

  alias Api.Ledger.Accounts
  alias Api.Utils
  alias ApiWeb.Endpoint

  alias Api.Schemas.{
    Account,
    AccountInstitution
  }

  describe "&get_accounts/1" do
    test "should return a list of accounts for each token" do
      [first_token, second_token | _] = Utils.get_valid_tokens()

      assert [
               %Account{id: account_1_id} = account_1
               | _
             ] = Accounts.get_accounts(first_token)

      assert [
               %Account{id: account_2_id} = account_2
               | _
             ] = Accounts.get_accounts(second_token)

      account_1_link = "#{Endpoint.url()}/accounts/#{account_1_id}"
      account_2_link = "#{Endpoint.url()}/accounts/#{account_2_id}"

      account_1_links = %{
        "self" => account_1_link,
        "balances" => "#{account_1_link}/balances",
        "details" => "#{account_1_link}/details",
        "transactions" => "#{account_1_link}/transactions"
      }

      account_2_links = %{
        "self" => account_2_link,
        "balances" => "#{account_2_link}/balances",
        "details" => "#{account_2_link}/details",
        "transactions" => "#{account_2_link}/transactions"
      }

      assert %Account{
               currency: "USD",
               enrollment_id: "c3fa4df8-e744-582c-b1ce-e9ac69669c1f",
               id: ^account_1_id,
               institution: %AccountInstitution{id: "chase", name: "Chase"},
               last_four: 3886,
               links: ^account_1_links,
               name: "My Checking",
               subtype: "checking",
               type: "depository"
             } = account_1

      assert %Account{
               currency: "USD",
               enrollment_id: "8cafcaf3-06db-5b38-9f2b-1b080bcf4621",
               id: ^account_2_id,
               institution: %AccountInstitution{
                 id: "bankofamerica",
                 name: "Bank of America"
               },
               last_four: 8684,
               links: ^account_2_links,
               name: "Jimmy Carter",
               subtype: "checking",
               type: "depository"
             } = account_2
    end
  end
end
