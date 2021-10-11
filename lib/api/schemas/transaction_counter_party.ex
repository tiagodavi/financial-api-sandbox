defmodule Api.Schemas.TransactionCounterParty do
  @moduledoc """
    Transaction CounterParty Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [:name, :type]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :name, :string
    field :type, :string
  end
end
