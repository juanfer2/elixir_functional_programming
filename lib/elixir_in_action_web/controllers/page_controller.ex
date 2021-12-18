defmodule ElixirInActionWeb.PageController do
  use ElixirInActionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
