defmodule DblogWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DBlog.Repo
  alias DblogWeb.Resolvers

  object :user do
    field :id, :id
    field :name, :string
    field :active, :boolean
    field :author, :author
  end

  object :author do
    field :id, :id
    field :bio, :string
    field :user, :user
    field :posts, list_of(:post) do
      arg :date, :date
      resolve &Resolvers.Blog.list_posts/3
    end
  end

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :author, :author
    field :inserted_at, :naive_datetime
  end
end
