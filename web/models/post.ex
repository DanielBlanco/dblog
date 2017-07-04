defmodule Dblog.Post do
  use Dblog.Web, :model

  schema "posts" do
    field :title, :string
    field :published_at, Timex.Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
