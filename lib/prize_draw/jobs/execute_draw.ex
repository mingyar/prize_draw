defmodule PrizeDraw.Jobs.ExecuteDraw do
  alias PrizeDraw.DrawContext
  use Oban.Worker, queue: :default, max_attempts: 1

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"draw_id" => draw_id}}) do
    draw_id
    |> DrawContext.list_entrants_by_draw()
    |> Enum.random()
    |> IO.inspect(label: "worker")
    |> DrawContext.update_entrant(%{winner: true})

    :ok
  end
end
