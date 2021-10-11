# Api

The Teller API is organized around REST. Resources have predictable, self-describing URLs and contain links to related resources. Our API accepts form-encoded requests and returns JSON encoded responses. It uses standard HTTP status codes, authentication, and methods in their usual ways.

# Available Routes
```
GET /accounts
GET /accounts/:id
GET /accounts/:account_id/details
GET /accounts/:account_id/balances
GET /accounts/:account_id/transactions
GET /accounts/:account_id/transactions/:id
```

# How to access the API?
Access tokens are encoded using HTTP Basic Auth.

The access token is given as the username value, 
the password field should be left empty and is ignored by the API server.

There are two tokens available:

Add a Header: Authorization: Basic test_i20hPR0aXKqi2f89KBF8bw

Add a Header: Authorization: Basic test_d9bgDb8AV0iCM0ji97bczg

# How to control API Versions?

Add a Header: Teller-Version: 2020-10-12

All controllers will receive api version through the connection

```
def index(%{private: %{version: version}} = conn, _params) do
	IO.inspect(version)
	render(conn, "index.json")
end
```
To find out more: ApiWeb.Plugs.EnsureApiVersion

# Libraries

Elixir 1.12.0

Erlang/OTP 22

Credo 1.5 (https://github.com/rrrene/credo)

Money 1.9 (https://github.com/elixirmoney/money)

.tool-versions file for asdf (https://github.com/asdf-vm/asdf)

# How to control quality with Static Analysis?

```
$ mix format
$ mix credo --strict
$ mix test
```

To find out more: https://github.com/rrrene/credo

To start your Phoenix server:

* Install dependencies with `mix deps.get`

* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.