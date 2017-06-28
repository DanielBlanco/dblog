defmodule Dblog.API.PostView do
  use Dblog.Web, :view

  def render("index.json", %{posts: posts}) do
    %{links: "todo", data: render_many(posts, Dblog.API.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{
      links: %{self: self_link(post)},
      data: render_one(post, Dblog.API.PostView, "post.json")
    }
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      type: "post",
      attributes: %{
        title: post.title,
        "published-at": post.published_at
      }
    }
  end

  # TODO: Find out how to use route helpers in view.
  defp self_link(model) do
    "/api/posts/"<>Integer.to_string(model.id)
  end
end
