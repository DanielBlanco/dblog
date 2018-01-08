defmodule Dblog.Blog.Post do
  use Dblog.Schema
  import Ecto.Changeset
  alias Dblog.Blog.{Post, Author}


  schema "posts" do
    field :body, :string
    field :title, :string
    belongs_to :author, Author

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:id, :title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 1, max: 100)
    |> unique_constraint(:id, name: :posts_pkey)
  end
end
