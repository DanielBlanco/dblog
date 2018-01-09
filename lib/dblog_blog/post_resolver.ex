defmodule Dblog.Blog.PostResolver do
  alias Dblog.Blog

  def all(_args, _info) do
    {:ok, Blog.list_posts()}
  end
end
