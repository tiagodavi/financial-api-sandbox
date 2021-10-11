defmodule ApiWeb.Plugs.EnsureApiVersion do
  @moduledoc """
  A default API version handler that can be used for versioning the API.
  """
  import Plug.Conn

  @default_version "2020-10-12"

  @doc false
  def init(default), do: default

  @doc false
  def call(conn, header: header, versions: versions) do
    version =
      conn
      |> get_req_header(header)
      |> List.first()

    if version in versions do
      put_private(conn, :version, version)
    else
      put_private(conn, :version, @default_version)
    end
  end

  @doc false
  def call(conn, _) do
    put_private(conn, :version, @default_version)
  end
end
