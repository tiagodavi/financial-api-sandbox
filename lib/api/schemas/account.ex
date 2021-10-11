defmodule Api.Schemas.Account do
  @moduledoc """
    Account Resource.
  """

  use Api.Schemas.EmbeddedSchema

  alias Api.Schemas.AccountInstitution

  @embeds [:institution]
  @required [
    :id,
    :name,
    :currency,
    :enrollment_id,
    :last_four,
    :links,
    :type,
    :subtype
  ]

  @derive {Jason.Encoder, only: @embeds ++ @required}

  embedded_schema do
    field :name, :string
    field :currency, :string, default: "USD"
    field :enrollment_id, :string
    field :last_four, :integer, default: 3886
    field :links, :map
    field :type, :string, default: "depository"
    field :subtype, :string, default: "checking"

    embeds_one :institution, AccountInstitution
  end
end
