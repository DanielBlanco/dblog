defmodule Dblog.Accounts.Credential do
  use Dblog.Schema
  import Ecto.Changeset
  alias Dblog.Accounts.{Credential, User}


  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  # Encrypts the password.
  defp put_pass_hash(changeset =
    %Ecto.Changeset{valid?: true, changes: %{password: p}}) do
    changeset
    |> put_change(:password_hash, Comeonin.Argon2.hashpwsalt(p))
    |> put_change(:password, nil)
  end
  defp put_pass_hash(changeset), do: changeset
end
