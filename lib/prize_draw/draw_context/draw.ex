defmodule PrizeDraw.DrawContext.Draw do
  use Ecto.Schema
  import Ecto.Changeset

  schema "draws" do
    field :date, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(draw, attrs) do
    draw
    |> cast(attrs, [:name, :date])
    |> validate_required([:name, :date])
  end
end
