defmodule ApiWeb.AccountControllerTest do
  use ApiWeb.ConnCase, async: true

  alias Api.Utils

  setup %{conn: conn} do
    [token_1, token_2 | _] = Utils.get_valid_tokens()
    [account_id | _] = Utils.get_valid_accounts()
    invalid_account_id = "21d7bf3a-0000-5b77-0000-1ff4774a6383"

    [
      conn: conn,
      token_1: token_1,
      token_2: token_2,
      index: Routes.account_path(conn, :index),
      show: Routes.account_path(conn, :show, account_id),
      not_found: Routes.account_path(conn, :show, invalid_account_id)
    ]
  end

  describe "GET /accounts" do
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

    test "should return a list of accounts for the given token", %{
      conn: conn,
      token_1: token_1,
      token_2: token_2,
      index: index
    } do
      http_response =
        conn
        |> add_token_to_connection(token_1)
        |> get(index)

      accounts = json_response(http_response, 200)
      assert [expected_account | _] = get_valid_accounts_json()
      assert [account] = accounts
      assert Map.equal?(account, expected_account)

      http_response =
        conn
        |> add_token_to_connection(token_2)
        |> get(index)

      accounts = json_response(http_response, 200)
      assert [_, expected_account | _] = get_valid_accounts_json()
      assert [account] = accounts
      assert Map.equal?(account, expected_account)
    end
  end

  describe "GET /accounts/:account_id" do
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

    test "should return 404 Not found when account does not exist", %{
      conn: conn,
      token_1: token_1,
      not_found: not_found
    } do
      http_response =
        conn
        |> add_token_to_connection(token_1)
        |> get(not_found)

      assert response(http_response, 404) =~ "Not found"
    end

    test "should return one single account", %{
      conn: conn,
      token_1: token_1,
      show: show
    } do
      http_response =
        conn
        |> add_token_to_connection(token_1)
        |> get(show)

      account = json_response(http_response, 200)

      assert [expected_account | _] = get_valid_accounts_json()

      assert Map.equal?(account, expected_account)
    end
  end

  defp get_valid_accounts_json do
    [
      %{
        "currency" => "USD",
        "enrollment_id" => "c3fa4df8-e744-582c-b1ce-e9ac69669c1f",
        "id" => "8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
        "institution" => %{"id" => "chase", "name" => "Chase"},
        "last_four" => 3886,
        "links" => %{
          "balances" =>
            "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/balances",
          "details" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/details",
          "self" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
          "transactions" =>
            "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/transactions"
        },
        "name" => "My Checking",
        "subtype" => "checking",
        "type" => "depository"
      },
      %{
        "currency" => "USD",
        "enrollment_id" => "8cafcaf3-06db-5b38-9f2b-1b080bcf4621",
        "id" => "77d6e00d-bf00-5748-8233-48e2f7b6dcce",
        "institution" => %{"id" => "bankofamerica", "name" => "Bank of America"},
        "last_four" => 8684,
        "links" => %{
          "balances" =>
            "#{@endpoint.url()}/accounts/77d6e00d-bf00-5748-8233-48e2f7b6dcce/balances",
          "details" => "#{@endpoint.url()}/accounts/77d6e00d-bf00-5748-8233-48e2f7b6dcce/details",
          "self" => "#{@endpoint.url()}/accounts/77d6e00d-bf00-5748-8233-48e2f7b6dcce",
          "transactions" =>
            "#{@endpoint.url()}/accounts/77d6e00d-bf00-5748-8233-48e2f7b6dcce/transactions"
        },
        "name" => "Jimmy Carter",
        "subtype" => "checking",
        "type" => "depository"
      }
    ]
  end
end
