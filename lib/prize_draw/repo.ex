defmodule PrizeDraw.Repo do
  use Ecto.Repo,
    otp_app: :prize_draw,
    adapter: Ecto.Adapters.Postgres
end
