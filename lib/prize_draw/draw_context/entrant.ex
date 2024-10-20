defmodule PrizeDraw.DrawContext.Entrant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entrants" do
    belongs_to :user, PrizeDraw.DrawContext.User
    belongs_to :draw, PrizeDraw.DrawContext.Draw
    field :winner, :boolean, default: false
    field :ticket, Ecto.UUID, autogenerate: true

    timestamps()
  end

  @doc false
  def changeset(entrant, attrs) do
    entrant
    |> cast(attrs, [:user_id, :draw_id, :winner])
    |> validate_required([:user_id, :draw_id])
  end
end
