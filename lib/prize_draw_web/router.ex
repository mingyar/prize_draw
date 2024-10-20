defmodule PrizeDrawWeb.Router do
  use PrizeDrawWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrizeDrawWeb do
    pipe_through :api

    resources "/user", UserController

    resources "/draw", DrawController

    resources "/entrant", EntrantController

    get "/draw/:id/winner", DrawController, :winner
  end
end
