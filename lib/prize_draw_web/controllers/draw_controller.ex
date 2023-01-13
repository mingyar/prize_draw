defmodule PrizeDrawWeb.DrawController do
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
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.draw_path(conn, :show, draw))
      |> render("show.json", draw: draw)
    end
  end

  def execute_draw(conn, %{"id" => id}) do
    draw = DrawContext.get_draw!(id)

    case Date.compare(draw.date, Date.utc_today()) do
      :lt ->
        conn
        |> put_status(:bad_request)
        |> put_view(PrizeDrawWeb.ErrorView)
        |> render("not_allowed_after_date.json")

      _ ->
        winner =
          DrawContext.list_users_draw(id)
          |> Enum.random()

        conn
        |> put_status(:ok)
        |> render("winner.json", user: winner)
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
end
