defmodule DblogWeb.Resolvers.Blog do
  alias Dblog.Blog

  def list_authors(_args, _info) do
    {:ok, Blog.list_authors()}
  end

  def get_author(_parent, %{id: id}, _resolution) do
    case Blog.get_author(id) do
      nil ->
        {:error, "Author ID #{id} not found"}
      post ->
        {:ok, post}
    end
  end

  def list_posts(%Blog.Author{} = author, args, _resolution) do
    {:ok, Blog.list_posts(author, args)}
  end

  def list_posts(_args, _info) do
    {:ok, Blog.list_posts()}
  end

  def get_post(_parent, %{id: id}, _resolution) do
    case Blog.get_post(id) do
      nil ->
        {:error, "Post ID #{id} not found"}
      post ->
        {:ok, post}
    end
  end

  @doc """
  Crates a new post.
  """
  def create_post(_parent, args, %{context: %{current_user: user}}) do
    user
    |> Blog.get_or_create_author!()
    |> Blog.create_post(args)
  end
  def create_post(_parent, _args, _resolution) do
    {:error, "Oops! Authentication error."}
  end

end
