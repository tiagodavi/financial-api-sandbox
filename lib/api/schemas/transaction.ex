defmodule Api.Schemas.Transaction do
  @moduledoc """
    Transaction Resource.
  """

  use Api.Schemas.EmbeddedSchema

  alias Api.Schemas.TransactionDetail

  @embeds [:details]
  @required [
    :id,
    :account_id,
    :amount,
    :date,
    :description,
    :links,
    :running_balance,
    :status,
    :type
  ]

  @derive {Jason.Encoder, only: @embeds ++ @required}

  embedded_schema do
    field :account_id, :string
    field :amount, Money.Ecto.Amount.Type
    field :date, :date
    field :description, :string
    field :links, :map
    field :running_balance, Money.Ecto.Amount.Type
    field :status, :string
    field :type, :string

    embeds_one :details, TransactionDetail
  end
end
