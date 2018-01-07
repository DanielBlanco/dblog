defmodule DblogWeb.PageController do
  use DblogWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
