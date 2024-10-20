defmodule PrizeDrawWeb.DrawController do
  alias PrizeDraw.Jobs.ExecuteDraw
  use PrizeDrawWeb, :controller

  alias PrizeDraw.DrawContext
  alias PrizeDraw.DrawContext.Draw

  action_fallback PrizeDrawWeb.FallbackController

  def index(conn, _params) do
    draws = DrawContext.list_draws()
    render(conn, "index.json", draws: draws)
  end

  def create(conn, %{"draw" => draw_params}) do
    with {:ok, %Draw{} = draw} <- DrawContext.create_draw(draw_params) do
      %{"draw_id" => draw.id}
      |> ExecuteDraw.new(scheduled_at: draw.date)
      |> Oban.insert()

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.draw_path(conn, :show, draw))
      |> render("show.json", draw: draw)
    end
  end

  def show(conn, %{"id" => id}) do
    draw = DrawContext.get_draw!(id)
    render(conn, "show.json", draw: draw)
  end

  def update(conn, %{"id" => id, "draw" => draw_params}) do
    draw = DrawContext.get_draw!(id)

    with {:ok, %Draw{} = draw} <- DrawContext.update_draw(draw, draw_params) do
      render(conn, "show.json", draw: draw)
    end
  end

  def delete(conn, %{"id" => id}) do
    draw = DrawContext.get_draw!(id)

    with {:ok, %Draw{}} <- DrawContext.delete_draw(draw) do
      send_resp(conn, :no_content, "")
    end
  end

  def winner(conn, %{"id" => id}) do
    winner =
      id
      |> DrawContext.get_draw!()
      |> Map.get(:id)
      |> DrawContext.list_entrants_by_draw()
      |> Enum.filter(&(&1.winner == true))
      |> hd()
      |> Map.get(:user)

    render(conn, "winner.json", user: winner)
  end
end
