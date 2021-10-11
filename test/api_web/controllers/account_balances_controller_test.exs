defmodule ApiWeb.AccountBalancesControllerTest do
  use ApiWeb.ConnCase, async: true

  alias Api.Utils

  setup %{conn: conn} do
    [token | _] = Utils.get_valid_tokens()
    [account_id | _] = Utils.get_valid_accounts()
    invalid_account_id = "21d7bf3a-0000-5b77-0000-1ff4774a6383"

    [
      conn: conn,
      token: token,
      index: Routes.account_balances_path(conn, :index, account_id),
      not_found: Routes.account_balances_path(conn, :index, invalid_account_id)
    ]
  end

  describe "GET /accounts/:account_id/balances" do
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

    test "should return 401 Unauthorized when account belongs to another token",
         %{conn: conn, token: token, not_found: not_found} do
      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(not_found)

      assert response(http_response, 401) =~ "Unauthorized"
    end

    test "should return account balances", %{
      conn: conn,
      token: token,
      index: index
    } do
      http_response =
        conn
        |> add_token_to_connection(token)
        |> get(index)

      account_balances = json_response(http_response, 200)

      links = %{
        "account" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
        "self" => "#{@endpoint.url()}/accounts/8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f/balances"
      }

      assert %{
               "account_id" => "8b6d213d-1d1a-5caa-a2d9-ff3d28117c6f",
               "links" => ^links,
               "available" => "8650.00",
               "ledger" => "8650.00"
             } = account_balances
    end
  end
end
