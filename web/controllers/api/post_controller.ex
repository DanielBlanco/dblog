defmodule Dblog.API.PostController do
  use Dblog.Web, :controller

  alias Dblog.Post

  def index(conn, _params) do
    render(conn, "index.json", posts: Repo.all(Post))
  end

end
