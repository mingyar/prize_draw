defmodule PrizeDrawWeb.EntrantController do
  use PrizeDrawWeb, :controller

  alias PrizeDraw.DrawContext
  alias PrizeDraw.DrawContext.Entrant

  action_fallback PrizeDrawWeb.FallbackController

  def index(conn, %{"draw_id" => draw_id}) do
    entrants = DrawContext.list_entrants_by_draw(draw_id)
    render(conn, "index.json", entrants: entrants)
  end

  def index(conn, _params) do
    entrants = DrawContext.list_entrants()
    render(conn, "index.json", entrants: entrants)
  end

  def create(conn, %{"entrant" => %{"user_id" => user_id, "draw_id" => draw_id} = _entrant_params}) do
    draw = DrawContext.get_draw!(draw_id)

    case DateTime.compare(draw.date, DateTime.utc_now()) do
      :gt ->
        entrant_user_ids = draw.entrants |> Enum.map(& &1.user_id)

        case Enum.member?(entrant_user_ids, user_id) do
          true ->
            conn
            |> put_status(:bad_request)
            |> put_view(PrizeDrawWeb.ErrorView)
            |> render("already_in_a_draw.json")

          false ->
            with {:ok, %Entrant{} = entrant} <-
                   DrawContext.create_entrant(%{user_id: user_id, draw_id: draw_id}) do
              conn
              |> put_status(:ok)
              |> text("You have been added to the draw! Your ticket number is: #{entrant.ticket}")
            end
        end

      _ ->
        conn
        |> put_status(:bad_request)
        |> put_view(PrizeDrawWeb.ErrorView)
        |> render("not_allowed_after_date.json")
    end
  end

  def show(conn, %{"id" => id}) do
    entrant = DrawContext.get_entrant!(id)
    render(conn, "show.json", entrant: entrant)
  end

  def update(conn, %{"id" => id, "entrant" => entrant_params}) do
    entrant = DrawContext.get_entrant!(id)

    with {:ok, %Entrant{} = entrant} <- DrawContext.update_entrant(entrant, entrant_params) do
      render(conn, "show.json", entrant: entrant)
    end
  end

  def delete(conn, %{"id" => id}) do
    entrant = DrawContext.get_entrant!(id)

    with {:ok, %Entrant{}} <- DrawContext.delete_entrant(entrant) do
      send_resp(conn, :no_content, "")
    end
  end
end
