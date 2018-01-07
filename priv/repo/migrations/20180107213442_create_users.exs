defmodule Dblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, null: false, primary_key: true
      add :name, :string
      add :active, :boolean, default: true, null: false

      timestamps()
    end

  end
end
