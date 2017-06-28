defmodule Dblog.API.PostViewTest do
  use Dblog.ConnCase, async: true

  alias Dblog.API.PostView

  test "index.json" do
    post1 = insert(:post)
    post2 = insert(:post)
    insert(:post)
    json = PostView.render("index.json", %{posts: [post1, post2]})
    assert json == %{ links: "todo", data: [json(post1), json(post2)] }
  end

  defp json(post), do: PostView.render("post.json", post: post)
end
