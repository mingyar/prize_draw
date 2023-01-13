defmodule PrizeDraw.DrawContext.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :draw_id, :integer
    field :email, :string
    field :name, :string
    field :winner, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def assign_to_draw_changesetset(user, attrs) do
    user
    |> cast(attrs, [:draw_id])
    |> validate_required([:draw_id])
  end
end
