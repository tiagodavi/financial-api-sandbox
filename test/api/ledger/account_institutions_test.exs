defmodule Api.Ledger.AccountInstitutionsTest do
  use Api.DataCase, async: true

  alias Api.Ledger.AccountInstitutions
  alias Api.Schemas.AccountInstitution

  describe "&get_account_institutions/0" do
    test "should return a list of account institutions" do
      [acc_1, acc_2 | _] = AccountInstitutions.get_account_institutions()

      assert %AccountInstitution{
               id: "chase",
               name: "Chase"
             } = acc_1

      assert %AccountInstitution{
               id: "bankofamerica",
               name: "Bank of America"
             } = acc_2
    end
  end
end
