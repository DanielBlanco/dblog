defmodule DblogWeb.Schema do
  use Absinthe.Schema
  alias DblogWeb.Resolvers
  alias DblogWeb.Schema.Middleware

  import_types Absinthe.Type.Custom
  import_types DblogWeb.Schema.Type.Account
  import_types DblogWeb.Schema.Type.Blog

  query do

    field :author, :author do
      arg :id, non_null(:id)
      middleware Middleware.BinaryId
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
      middleware Middleware.BinaryId
      resolve &Resolvers.Accounts.get_user/3
    end

  end

  mutation do

    @desc "Updates an user"
    field :update_user, type: :user do
      arg :id, non_null(:id)
      arg :user, :update_user_params

      middleware Middleware.BinaryId
      middleware Middleware.Authentication
      resolve &Resolvers.Accounts.update_user/3
    end

    # @desc "Create a post"
    # field :create_post, type: :post do
    #   arg :title, non_null(:string)
    #   arg :body, non_null(:string)
    #   # arg :published_at, :naive_datetime

    #   resolve &Resolvers.Blog.create_post/3
    # end

  end
end
