defmodule Api.Ledger.MerchantsTest do
  use Api.DataCase, async: true

  alias Api.Ledger.Merchants

  describe "&get_merchants/0" do
    test "should return a list of merchants" do
      assert Enum.count(Merchants.get_merchants()) > 0
    end
  end

  describe "&get_merchant_categories/0" do
    test "should return a list of merchant categories" do
      assert Enum.count(Merchants.get_merchant_categories()) > 0
    end
  end
end
