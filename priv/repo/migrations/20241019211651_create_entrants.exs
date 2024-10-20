defmodule PrizeDraw.Repo.Migrations.CreateEntrants do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:entrants) do
      add :winner, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :draw_id, references(:draws, on_delete: :nothing)
      add :ticket, :uuid, default: fragment("uuid_generate_v4()"), null: false

      timestamps()
    end

    create index(:entrants, [:user_id])
    create index(:entrants, [:draw_id])
  end
end
