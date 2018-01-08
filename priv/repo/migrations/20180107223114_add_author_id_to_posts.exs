defmodule Dblog.Repo.Migrations.AddAuthorIdToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :author_id,
          references(:authors, type: :binary_id, on_delete: :delete_all),
          null: false
    end

    create index(:posts, [:author_id])
  end
end
