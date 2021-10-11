defimpl Jason.Encoder, for: Money do
  def encode(%{__struct__: _} = struct, opts) do
    value = Money.to_string(struct)
    Jason.Encode.string(value, opts)
  end
end
