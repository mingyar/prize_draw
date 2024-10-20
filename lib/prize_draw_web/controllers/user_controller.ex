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

  def delete(conn, %{"id" => id}) do
    user = DrawContext.get_user!(id)

    with {:ok, %User{}} <- DrawContext.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
