defmodule PrizeDrawWeb.Router do
  use PrizeDrawWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrizeDrawWeb do
    pipe_through :api

    resources "/user", UserController

    post "/user/assign_to_draw", UserController, :assign_to_draw

    resources "/draw", DrawController

    post "/draw/execute_draw/:id", DrawController, :execute_draw
  end
end
