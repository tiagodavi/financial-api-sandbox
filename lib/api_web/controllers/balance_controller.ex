defmodule ApiWeb.BalanceController do
  use ApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
