defmodule PrizeDrawWeb.UserController do
  use PrizeDrawWeb, :controller

  alias PrizeDraw.DrawContext
  alias PrizeDraw.DrawContext.User

  action_fallback PrizeDrawWeb.FallbackController

  def index(conn, _params) do
    users = DrawContext.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- DrawContext.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = DrawContext.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = DrawContext.get_user!(id)

    with {:ok, %User{} = user} <- DrawContext.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def assign_to_draw(conn, %{"user" => %{"id" => id, "draw_id" => draw_id} = user_params}) do
    user = DrawContext.get_user!(id)

    case user.draw_id == nil or user.draw_id != draw_id do
      true ->
        draw = DrawContext.get_draw!(draw_id)

        case Date.compare(draw.date, Date.utc_today()) do
          :gt ->
            with {:ok, %User{} = _user} <- DrawContext.assign_to_draw(user, user_params) do
              conn
              |> put_status(:ok)
              |> text("")
            end

          :lt ->
            conn
            |> put_status(:bad_request)
            |> put_view(PrizeDrawWeb.ErrorView)
            |> render("not_allowed_after_date.json")
        end

      false ->
        conn
        |> put_status(:bad_request)
        |> put_view(PrizeDrawWeb.ErrorView)
        |> render("already_in_a_draw.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = DrawContext.get_user!(id)

    with {:ok, %User{}} <- DrawContext.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
