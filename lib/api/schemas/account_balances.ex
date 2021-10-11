defmodule Api.Schemas.AccountBalances do
  @moduledoc """
    Account Balances Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [
    :account_id,
    :available,
    :ledger,
    :links
  ]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :account_id, :string
    field :available, Money.Ecto.Amount.Type
    field :ledger, Money.Ecto.Amount.Type
    field :links, :map
  end
end
