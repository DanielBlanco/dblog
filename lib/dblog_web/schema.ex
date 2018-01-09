defmodule DblogWeb.Schema do
  use Absinthe.Schema
  alias DblogWeb.Resolvers

  import_types Absinthe.Type.Custom
  import_types DblogWeb.Schema.Types

  query do
    field :author, :author do
      arg :id, non_null(:id)
      resolve &Resolvers.Blog.get_author/3
    end

    @desc "Get all authors"
    field :authors, list_of(:author) do
      resolve &Resolvers.Blog.list_authors/2
    end

    @desc "Get all posts"
    field :posts, list_of(:post) do
      resolve &Resolvers.Blog.list_posts/2
    end

    field :users, list_of(:user) do
      resolve &Resolvers.Accounts.list_users/2
    end

    @desc "Get a user of the blog"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.get_user/3
    end

  end
end
