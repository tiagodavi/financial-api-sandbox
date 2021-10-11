defmodule Api.Schemas.TransactionDetail do
  @moduledoc """
    Transaction Detail Resource.
  """

  use Api.Schemas.EmbeddedSchema

  alias Api.Schemas.TransactionCounterParty

  @embeds [:counterparty]
  @required [:category, :processing_status]

  @derive {Jason.Encoder, only: @embeds ++ @required}

  embedded_schema do
    field :category, :string
    field :processing_status, :string

    embeds_one :counterparty, TransactionCounterParty
  end
end
