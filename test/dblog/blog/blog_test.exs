defmodule Dblog.BlogTest do
  use Dblog.DataCase

  alias Dblog.Blog

  describe "posts" do
    alias Dblog.Blog.Post

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      attrs = attrs |> Enum.into(@valid_attrs)
      {:ok, post} =
        insert(:user)
        |> Blog.get_or_create_author!()
        |> Blog.create_post(attrs)

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      ids = Blog.list_posts() |> Enum.map(&(&1.id))
      assert ids == [post.id]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      p = Blog.get_post!(post.id)
      assert p.id == post.id
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} =
        insert(:author)
        |> Blog.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
        insert(:author)
        |> Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.body == "some updated body"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      p = Blog.get_post!(post.id)
      assert post.id == p.id
      assert post.body == p.body
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "authors" do
    alias Dblog.Blog.Author

    @valid_attrs %{bio: "some bio"}
    @update_attrs %{bio: "some updated bio"}
    @invalid_attrs %{bio: nil}

    def author_fixture(attrs \\ %{}) do
      attrs = attrs |> Enum.into(@valid_attrs)
      {:ok, author} =
        insert(:user)
        |> Blog.create_author(attrs)

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Blog.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Blog.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} =
        insert(:user)
        |> Blog.create_author(@valid_attrs)
      assert author.bio == "some bio"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
        insert(:user)
        |> Blog.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, author} = Blog.update_author(author, @update_attrs)
      assert %Author{} = author
      assert author.bio == "some updated bio"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_author(author, @invalid_attrs)
      assert author == Blog.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Blog.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Blog.change_author(author)
    end
  end
end
