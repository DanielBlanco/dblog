defmodule Dblog.User do
  use Dblog.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  # Encrypts the password.
  defp put_pass_hash(changeset = %Ecto.Changeset{valid?: true, changes: %{password: p}}) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(p))
  end
  defp put_pass_hash(changeset), do: changeset
end
