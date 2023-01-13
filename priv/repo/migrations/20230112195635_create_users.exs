defmodule PrizeDraw.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :winner, :boolean, default: false, null: false
      add :draw_id, references(:draws)

      timestamps()
    end
  end
end
