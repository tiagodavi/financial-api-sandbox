defmodule Api.Schemas.AccountDetails do
  @moduledoc """
    Account Details Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [
    :account_id,
    :account_number,
    :links,
    :routing_numbers
  ]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :account_id, :string
    field :account_number, :integer
    field :links, :map
    field :routing_numbers, :map
  end
end
