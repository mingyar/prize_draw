defmodule PrizeDrawWeb.EntrantView do
  use PrizeDrawWeb, :view
  alias PrizeDrawWeb.EntrantView

  def render("index.json", %{entrants: entrants}) do
    %{data: render_many(entrants, EntrantView, "entrant.json")}
  end

  def render("show.json", %{entrant: entrant}) do
    %{data: render_one(entrant, EntrantView, "entrant.json")}
  end

  def render("entrant.json", %{entrant: entrant}) do
    %{
      id: entrant.id,
      ticket: entrant.ticket,
      winner: entrant.winner
    }
  end
end
