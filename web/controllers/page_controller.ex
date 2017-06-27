defmodule Dblog.PageController do
  use Dblog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
