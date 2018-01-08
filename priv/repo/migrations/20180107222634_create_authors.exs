defmodule Dblog.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :binary_id, null: false, primary_key: true
      add :bio, :text
      add :user_id,
          references(:users, type: :binary_id, on_delete: :delete_all),
          null: false

      timestamps()
    end

    create unique_index(:authors, [:user_id])
  end
end
