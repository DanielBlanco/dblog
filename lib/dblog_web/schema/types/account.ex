defmodule DblogWeb.Schema.Type.Account do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DBlog.Repo

  object :user do
    field :id, :id
    field :name, :string
    field :active, :boolean
    field :author, :author
    field :email, :string
  end

  @desc "A way to update an user"
  input_object :update_user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end
end
