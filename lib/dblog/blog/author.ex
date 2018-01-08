defmodule Dblog.Blog.Author do
  use Dblog.Schema
  import Ecto.Changeset
  alias Dblog.Blog.{Author, Post}


  schema "authors" do
    field :bio, :string
    has_many :posts, Post
    belongs_to :user, Dblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Author{} = author, attrs) do
    author
    |> cast(attrs, [:id, :bio])
    |> validate_required([:bio])
    |> unique_constraint(:user_id)
    |> unique_constraint(:id, name: :authors_pkey)
  end
end
