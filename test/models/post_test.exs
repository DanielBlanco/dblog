defmodule Dblog.PostTest do
  use Dblog.ModelCase

  alias Dblog.Post

  @valid_attrs %{
    title: "ELM + Phoenix |> exito!"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  # test "published_at should only allow future dates" do
  #   assert true
  # end
end
