defmodule DblogWeb.PostController do
  use DblogWeb, :controller

  alias Dblog.Blog
  alias Dblog.Blog.Post

  action_fallback DblogWeb.FallbackController
  plug :require_existing_author
  plug :authorize_post when action in [:update, :delete]

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    author = current_author(conn)
    with {:ok, %Post{} = post} <- Blog.create_post(author, post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"post" => post_params}) do
    post = conn.assigns.post

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, _) do
    post = conn.assigns.post
    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end

  # Requires an author for the page.
  defp require_existing_author(conn, _) do
    author =
      current_user(conn)
      |> Blog.get_or_create_author!()
    assign(conn, :current_author, author)
  end

  # Authors should modify their own posts.
  defp authorize_post(conn, _) do
    post = Blog.get_post!(conn.params["id"])

    if current_author(conn).id == post.author_id do
      assign(conn, :post, post)
    else
      conn
      |> forbidden!()
      |> halt()
    end
  end
end
