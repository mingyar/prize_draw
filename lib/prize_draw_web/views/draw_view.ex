defmodule PrizeDrawWeb.DrawView do
  use PrizeDrawWeb, :view
  alias PrizeDrawWeb.DrawView

  def render("index.json", %{draws: draws}) do
    %{data: render_many(draws, DrawView, "draw.json")}
  end

  def render("show.json", %{draw: draw}) do
    %{data: render_one(draw, DrawView, "draw.json")}
  end

  def render("draw.json", %{draw: draw}) do
    %{
      id: draw.id,
      date: draw.date
    }
  end

  def render("winner.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
