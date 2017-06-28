defmodule Dblog.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :published_at, :utc_datetime

      timestamps()
    end

  end
end
