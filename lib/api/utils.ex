defmodule Api.Utils do
  @moduledoc """
  Utility functions for general purposes.
  """

  @first_generated_account_id "8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f"
  @second_generated_account_id "77d6e00d-bf00-5748-8233-48e2f7b6dcce"

  @first_generated_token "test_i20hPR0aXKqi2f89KBF8bw"
  @second_generated_token "test_d9bgDb8AV0iCM0ji97bczg"

  @spec get_from_cycle(nonempty_list(term()), nonempty_list(term())) :: {term(), list()}
  def get_from_cycle([head | tail], [_ | _]) do
    {head, tail}
  end

  @spec get_from_cycle(list(), nonempty_list(term())) :: {term(), list()}
  def get_from_cycle([], [_ | _] = items) do
    get_from_cycle(items, items)
  end

  @spec get_from_cycle(any(), any()) :: nil
  def get_from_cycle(_, _), do: nil

  @spec get_valid_tokens() :: list(String.t())
  def get_valid_tokens do
    [@first_generated_token, @second_generated_token]
  end

  @spec get_valid_accounts() :: list(String.t())
  def get_valid_accounts do
    [@first_generated_account_id, @second_generated_account_id]
  end

  @spec get_token_accounts() :: map()
  def get_token_accounts do
    %{
      @first_generated_token => @first_generated_account_id,
      @second_generated_token => @second_generated_account_id
    }
  end
end
