defmodule Dblog.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Dblog.Repo

  alias Dblog.Blog.{Post, Author}
  alias Dblog.Accounts

  @doc """
  Returns the list of posts for an author in a given date.

  ## Examples

      iex> list_posts(%Author{}, %{date: "2018-01-01"})
      [%Post{}, ...]

  TODO: Change inserted_at for published_at.
  """
  def list_posts(author, %{date: date}) do
    from(p in Post,
      where: p.author_id == ^author.id,
      where: fragment("date_trunc('day', ?)", p.inserted_at) == type(^date, :date))
    |> Repo.all
  end

  @doc """
  Returns the list of posts for an author.

  ## Examples

      iex> list_posts(%Author{}, %{})
      [%Post{}, ...]

  """
  def list_posts(author, _) do
    from(t in Post, where: t.author_id == ^author.id)
    |> Repo.all
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
    |> Repo.preload(author: :user)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Repo.get!(Post, id)
    |> Repo.preload(author: :user)
  end

  @doc """
  Gets a single post.

  Returns `nil` if the Post does not exist.

  ## Examples

      iex> get_post(123)
      %Post{}

      iex> get_post(456)
      nil

  """
  def get_post(id) do
    Repo.get(Post, id)
    |> Repo.preload(author: :user)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%Author{}, %{field: value})
      {:ok, %Post{}}

      iex> create_post(%Author{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%Author{} = author, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, author.id)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Gets a single author.

  Returns `nil` if the Author does not exist.

  ## Examples

      iex> get_author(123)
      %Author{}

      iex> get_author(456)
      nil

  """
  def get_author(id), do: Repo.get(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%Accounts.User{}, %{field: value})
      {:ok, %Author{}}

      iex> create_author(%Accounts.User{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(%Accounts.User{} = user, attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, user.id)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{source: %Author{}}

  """
  def change_author(%Author{} = author) do
    Author.changeset(author, %{})
  end

  @doc """
  Find or create an author for an existing user.

  ## Examples

      iex> find_or_create_author!(user)
      %Author{}

  """
  def get_or_create_author!(%Accounts.User{} = user) do
    user
    |> create_author(%{bio: "..."})
    |> handle_existing_author()
  end
  defp handle_existing_author({:ok, author}), do: author
  defp handle_existing_author({:error, changeset}) do
    Author
    |> Repo.get_by!(user_id: changeset.changes.user_id)
  end
end
