defmodule Dblog.Accounts.AuthorResolver do
  alias Dblog.Blog

  def all(_args, _info) do
    {:ok, Blog.list_authors()}
  end
end
