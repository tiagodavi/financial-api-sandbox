defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ApiWeb.Plugs.BasicAuth

    plug ApiWeb.Plugs.EnsureApiVersion,
      header: "teller-version",
      versions: [
        "2020-10-12"
      ]
  end

  scope "/", ApiWeb do
    pipe_through :api

    scope "/accounts" do
      resources "/", AccountController, only: [:show, :index] do
        resources "/details", AccountDetailsController, as: :details, only: [:index]
        resources "/balances", AccountBalancesController, as: :balances, only: [:index]
        resources "/transactions", TransactionController, only: [:show, :index]
      end
    end
  end
end
