defmodule Api.Schemas.AccountInstitution do
  @moduledoc """
    Account Institution Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [
    :id,
    :name
  ]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :name, :string
  end
end
