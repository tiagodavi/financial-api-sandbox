defmodule Api.Schemas.EmbeddedSchema do
  @moduledoc """
  Macro with helper functionality for embedded schemas.
  """
  @callback changeset(Schema.t(), map()) :: Changeset.t()
  @callback from_map(map()) :: any()

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @behaviour unquote(__MODULE__)

      @type t :: %__MODULE__{}

      @before_compile unquote(__MODULE__)

      @embeds []
      @optional []
      @required []
      @virtual [:id]
    end
  end

  # credo:disable-for-next-line Credo.Check.Refactor.ABCSize
  defmacro __before_compile__(_opts) do
    quote generated: true, location: :keep do
      @impl true
      def changeset(schema, attrs \\ %{})

      def changeset(%__MODULE__{} = schema, attrs) do
        changeset = cast(schema, attrs, @required ++ @optional ++ @virtual)

        @embeds
        |> Enum.reduce(changeset, fn val, acc ->
          cast_embed(acc, val)
        end)
        |> validate_required(@required)
      end

      @impl true
      def from_map(attrs), do: %__MODULE__{} |> changeset(attrs) |> apply_action(:insert)

      defoverridable changeset: 2, from_map: 1
    end
  end
end
