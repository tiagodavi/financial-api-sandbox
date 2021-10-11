defmodule Api.UtilsTest do
  use ExUnit.Case, async: true

  alias Api.Utils

  describe "&get_from_cycle/2" do
    test "should return the head and the tail in a tuple" do
      assert {1, [2 | []]} = Utils.get_from_cycle([1, 2], [1, 2])
    end

    test "should return the same head after consuming the main list" do
      assert {1, tail} = Utils.get_from_cycle([1, 2], [1, 2])
      assert {2, tail} = Utils.get_from_cycle(tail, [1, 2])
      assert {1, [2 | []]} = Utils.get_from_cycle(tail, [1, 2])
    end

    test "should return nil when any params are not lists" do
      assert Utils.get_from_cycle("anything", [1, 2]) == nil
    end
  end
end
