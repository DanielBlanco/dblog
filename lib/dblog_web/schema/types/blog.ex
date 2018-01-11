defmodule DblogWeb.Schema.Type.Blog do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DBlog.Repo
  alias DblogWeb.Resolvers

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
