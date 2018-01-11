defmodule Dblog.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]
  import Ecto.Query, warn: false
  alias Dblog.Repo

  alias Dblog.Accounts.{Credential, User}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    |> Repo.preload(:credential)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
    |> Repo.preload(:credential)
  end

  @doc """
  Gets a single user.

  Returns `nil` if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(id) do
    Repo.get(User, id)
    |> Repo.preload(:credential)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Authenticates an user.

  If we find a matching user, we return the user.

  If the password doesn't match or the user does not exists, we return
  :unauthorized.

  When a user isn't found, we use comeonin's `Comeonin.Argon2.dummy_checkpw/0`
  function to simulate a password check with variable timing. This hardens our
  authentication layer against timing attacks, which is crucial to keeping our
  applications secure.

  ## Examples

      iex> authenticate("some@email.com", "password")
      {:ok, %User{}}

  """
  def authenticate(email, password) do
    user = find_user_to_authenticate(email)
    cond do
      user && checkpw(password, user.credential.password_hash) ->
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true ->
        dummy_checkpw()
        {:error, :unauthorized}
    end
  end

  defp find_user_to_authenticate(email) do
    query =
      from u in User,
        inner_join: c in assoc(u, :credential),
        where: c.email == ^email

    Repo.one(query)
    |> Repo.preload(:credential)
  end
end
