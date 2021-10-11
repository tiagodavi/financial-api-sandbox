defmodule Api.Schemas.MerchantCategory do
  @moduledoc """
    Merchant Category Resource.
  """

  use Api.Schemas.EmbeddedSchema

  @required [:name]

  @derive {Jason.Encoder, only: @required}

  embedded_schema do
    field :name, :string
  end
end
