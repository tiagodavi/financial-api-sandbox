defmodule Api.Ledger.Merchants do
  @moduledoc """
    Merchants Context.
  """

  alias Api.Schemas.{
    Merchant,
    MerchantCategory
  }

  @spec get_merchants() :: list(Merchant.t())
  def get_merchants do
    [
      %Merchant{
        counterparty: "UBER",
        id: "3268c405-a50c-4696-8386-b739b3e2f2c8",
        name: "Uber"
      },
      %Merchant{
        counterparty: "UBER EATS",
        id: "22e2dd93-f22b-4323-ac42-47499a82b58e",
        name: "Uber Eats"
      },
      %Merchant{
        counterparty: "FIVE GUYS",
        id: "a2f2e7e5-00a2-4888-9150-98bfbc2bb4e4",
        name: "Five Guys"
      },
      %Merchant{
        counterparty: "CHICK FIL A",
        id: "859f8167-f99a-42e4-8ea4-a8e5012f5400",
        name: "Chick-Fil-A"
      },
      %Merchant{
        counterparty: "AMC",
        id: "fcd931dc-182a-475e-8107-5fb8af2c208e",
        name: "AMC"
      },
      %Merchant{
        counterparty: "TARGET",
        id: "d61a742a-85cb-4066-867c-5953e58e24fc",
        name: "Target"
      },
      %Merchant{
        counterparty: "HOTEL TONIGHT",
        id: "235975f5-0181-4331-aeb6-82ca5e5116a9",
        name: "Hotel Tonight"
      },
      %Merchant{
        counterparty: "MISSON CEVICHE",
        id: "d1f58106-c375-46ff-a374-cb74fa2d33cd",
        name: "Misson Ceviche"
      },
      %Merchant{
        counterparty: "WINGSTOP",
        id: "376dcb4a-db9c-4ffe-bac9-a894f4119ebc",
        name: "Wingstop"
      },
      %Merchant{
        counterparty: "SLIM CHICKENS",
        id: "b06b1e76-a169-4ed4-bb06-a11e775ee7b0",
        name: "Slim Chickens"
      },
      %Merchant{
        counterparty: "CVS",
        id: "a346077b-8fc1-49b8-a3b9-19e6d1c5c19c",
        name: "CVS"
      },
      %Merchant{
        counterparty: "IN N OUT BURGER",
        id: "c3df4e61-e2ac-44af-87c9-2957f979c4c2",
        name: "In-N-Out Burger"
      },
      %Merchant{
        counterparty: "LYFT",
        id: "0468d27c-171c-4fb9-a77e-123034f2bec8",
        name: "Lyft"
      },
      %Merchant{
        counterparty: "AMAZON",
        id: "e7b0702f-e444-4dd0-90ee-c554eed9a430",
        name: "Amazon"
      },
      %Merchant{
        counterparty: "APPLE",
        id: "07fac0a1-38ff-48fa-b7cd-5a3a8dff31e4",
        name: "Apple"
      },
      %Merchant{
        counterparty: "WALMART",
        id: "6147948f-0fea-4559-9b92-f76640ae1b46",
        name: "Walmart"
      }
    ]
  end

  @spec get_merchant_categories() :: list(MerchantCategory.t())
  def get_merchant_categories do
    [
      %MerchantCategory{
        id: "cb89f11c-2e01-459c-a0cb-86d94caf16a4",
        name: "accommodation"
      },
      %MerchantCategory{
        id: "cdce0ef8-4d5f-4f6e-9bf2-0cc83bb0cd2d",
        name: "advertising"
      },
      %MerchantCategory{
        id: "672d35e8-b9d7-4169-87e0-1452d3e3b59b",
        name: "bar"
      },
      %MerchantCategory{
        id: "84a9d67d-3fd7-4068-ada7-8aafcb8b7302",
        name: "charity"
      },
      %MerchantCategory{
        id: "d81fce9d-6298-490e-aa06-d7f3f7419aee",
        name: "clothing"
      },
      %MerchantCategory{
        id: "846c8873-c36f-4f70-a58a-b8e5f7f253ec",
        name: "entertainment"
      },
      %MerchantCategory{
        id: "190a29e2-e2ac-43d3-b87d-c9d5ad857414",
        name: "fuel"
      },
      %MerchantCategory{
        id: "2fa7e272-a82f-408e-9b23-63d5a88e77f1",
        name: "groceries"
      },
      %MerchantCategory{
        id: "0e1e394e-e909-4bb9-ba3b-453d4765b243",
        name: "health"
      },
      %MerchantCategory{
        id: "984b978f-6b09-4064-a0bc-9d033c18dd28",
        name: "home"
      },
      %MerchantCategory{
        id: "2e73edb5-e65a-4673-8f59-1a2d8c9464e1",
        name: "income"
      },
      %MerchantCategory{
        id: "7047a4c4-175c-49d8-9740-89415570ea68",
        name: "insurance"
      },
      %MerchantCategory{
        id: "43bdf0cd-b23c-48bd-b3f1-88d7ab655670",
        name: "office"
      },
      %MerchantCategory{
        id: "8265594c-1875-465a-8e96-0ecf82532624",
        name: "phone"
      },
      %MerchantCategory{
        id: "5ed452fb-efc4-42ef-a740-f4483416f80d",
        name: "sport"
      },
      %MerchantCategory{
        id: "521b1119-c5e1-444d-96c5-342446becf0f",
        name: "tax"
      },
      %MerchantCategory{
        id: "864d4ff3-618a-4209-abf4-299caa715a92",
        name: "dining"
      },
      %MerchantCategory{
        id: "98cb3e6d-8aeb-458d-9d82-136e1706061a",
        name: "service"
      },
      %MerchantCategory{
        id: "680ceedb-4ed1-4be5-9638-086be1851070",
        name: "shopping"
      },
      %MerchantCategory{
        id: "54aeb81f-811f-4a6e-b388-5e66677a4596",
        name: "software"
      },
      %MerchantCategory{
        id: "40c8a246-785c-49a2-8e84-7dd9d2db938c",
        name: "utilities"
      }
    ]
  end

  @spec get_merchant_by_id(Ecto.UUID.t()) :: Merchant.t() | nil
  def get_merchant_by_id(merchant_id) do
    Enum.find(get_merchants(), &(&1.id == merchant_id))
  end

  @spec get_merchant_category_by_id(Ecto.UUID.t()) :: MerchantCategory.t() | nil
  def get_merchant_category_by_id(merchant_category_id) do
    Enum.find(get_merchant_categories(), &(&1.id == merchant_category_id))
  end
end
