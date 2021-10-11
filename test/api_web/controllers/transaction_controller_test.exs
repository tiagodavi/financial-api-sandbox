defmodule ApiWeb.TransactionControllerTest do
  use ApiWeb.ConnCase, async: true

  alias Api.Utils

  setup %{conn: conn} do
    [account_id | _] = Utils.get_valid_accounts()
    [token | _] = Utils.get_valid_tokens()
    valid_transaction_id = "21d7bf3a-c21c-5b77-919f-1ff4774a6383"
    invalid_transaction_id = "21d7bf3a-0000-5b77-0000-1ff4774a6383"

    [
      conn: conn,
      token: token,
      index: Routes.account_transaction_path(conn, :index, account_id),
      show: Routes.account_transaction_path(conn, :show, account_id, valid_transaction_id),
      not_found: Routes.account_transaction_path(conn, :show, account_id, invalid_transaction_id)
    ]
  end

  describe "GET /accounts/:account_id/transactions" do
    test "should return 401 Unauthorized when token is not provided", %{conn: conn, index: index} do
      http_response = get(conn, index)
      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return 401 Unauthorized when token is invalid", %{conn: conn, index: index} do
      http_response =
        conn
        |> add_token_to_connection("anything")
        |> get(index)

      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return 401 Unauthorized when trying to access account of other token", %{
      conn: conn,
      index: index
    } do
      [_, token | _] = Utils.get_valid_tokens()

      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(index)

      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return a list of transactions going back 90 days", %{
      conn: conn,
      token: token,
      index: index
    } do
      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(index)

      transactions = json_response(http_response, 200)
      transactions_limit = 90

      assert length(transactions) == transactions_limit
      assert [expected_transaction_1, expected_transaction_2] = get_valid_transactions_json()
      assert [transaction_1, transaction_2 | _] = transactions

      assert Map.equal?(transaction_1, expected_transaction_1)
      assert Map.equal?(transaction_2, expected_transaction_2)
    end
  end

  describe "GET /accounts/:account_id/transactions/:transaction_id" do
    test "should return 401 Unauthorized when token is not provided", %{conn: conn, show: show} do
      http_response = get(conn, show)
      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return 401 Unauthorized when token is invalid", %{conn: conn, show: show} do
      http_response =
        conn
        |> add_token_to_connection("anything")
        |> get(show)

      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return 401 Unauthorized when trying to access account of other token", %{
      conn: conn,
      show: show
    } do
      [_, token | _] = Utils.get_valid_tokens()

      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(show)

      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return 404 Not found when transaction does not exist", %{
      conn: conn,
      token: token,
      not_found: not_found
    } do
      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(not_found)

      assert response(http_response, 404) =~ "Not found"
    end

    test "should return one single transaction", %{
      conn: conn,
      token: token,
      show: show
    } do
      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(show)

      transaction = json_response(http_response, 200)

      assert [_, expected_transaction | _] = get_valid_transactions_json()

      assert Map.equal?(transaction, expected_transaction)
    end
  end

  defp get_valid_transactions_json do
    [
      %{
        "account_id" => "8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
        "amount" => "-5.00",
        "date" => "2021-10-07",
        "description" => "Walmart",
        "details" => %{
          "category" => "utilities",
          "counterparty" => %{"name" => "WALMART", "type" => "organization"},
          "processing_status" => "complete"
        },
        "id" => "4470aad9-3d17-5cc1-a291-94b18a924904",
        "links" => %{
          "account" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
          "self" =>
            "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/transactions/4470aad9-3d17-5cc1-a291-94b18a924904"
        },
        "running_balance" => "8650.00",
        "status" => "posted",
        "type" => "card_payment"
      },
      %{
        "account_id" => "8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
        "amount" => "-10.00",
        "date" => "2021-10-06",
        "description" => "Apple",
        "details" => %{
          "category" => "software",
          "counterparty" => %{"name" => "APPLE", "type" => "organization"},
          "processing_status" => "complete"
        },
        "id" => "21d7bf3a-c21c-5b77-919f-1ff4774a6383",
        "links" => %{
          "account" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
          "self" =>
            "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/transactions/21d7bf3a-c21c-5b77-919f-1ff4774a6383"
        },
        "running_balance" => "8655.00",
        "status" => "posted",
        "type" => "card_payment"
      }
    ]
  end
end
