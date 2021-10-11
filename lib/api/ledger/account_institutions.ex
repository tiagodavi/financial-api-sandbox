defmodule Api.Ledger.AccountInstitutions do
  @moduledoc """
    Account Institutions Context.
  """

  alias Api.Schemas.AccountInstitution

  @spec get_account_institutions() :: list(AccountInstitution.t())
  def get_account_institutions do
    [
      %AccountInstitution{
        id: "chase",
        name: "Chase"
      },
      %AccountInstitution{
        id: "bankofamerica",
        name: "Bank of America"
      },
      %AccountInstitution{
        id: "wellsfargo",
        name: "Wells Fargo"
      },
      %AccountInstitution{
        id: "citibank",
        name: "Citibank"
      },
      %AccountInstitution{
        id: "capitalone",
        name: "Capital One"
      }
    ]
  end
end
