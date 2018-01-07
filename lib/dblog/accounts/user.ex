defmodule Dblog.Accounts.User do
  use Dblog.Schema
  import Ecto.Changeset
  alias Dblog.Accounts.User


  schema "users" do
    field :name, :string
    field :active, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:id, :name, :active])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 100)
    |> unique_constraint(:id, name: :users_pkey)
  end
end
