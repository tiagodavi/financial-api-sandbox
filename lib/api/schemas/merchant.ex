defmodule Api.Schemas.Merchant do
  @moduledoc """
    Merchant Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [:name, :counterparty]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :name, :string
    field :counterparty, :string
  end
end
