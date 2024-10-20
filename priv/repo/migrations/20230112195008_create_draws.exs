defmodule PrizeDraw.Repo.Migrations.CreateDraws do
  use Ecto.Migration

  def change do
    create table(:draws) do
      add :name, :string
      add :date, :utc_datetime

      timestamps()
    end
  end
end
