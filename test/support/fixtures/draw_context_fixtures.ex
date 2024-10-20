defmodule PrizeDraw.DrawContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PrizeDraw.DrawContext` context.
  """

  @doc """
  Generate a draw.
  """
  def draw_fixture(attrs \\ %{}) do
    {:ok, draw} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-01-11],
        name: "some name"
      })
      |> PrizeDraw.DrawContext.create_draw()

    draw
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        draw_id: 42,
        email: "some email",
        name: "some name",
        password_hash: "some password_hash",
        winner: true
      })
      |> PrizeDraw.DrawContext.create_user()

    user
  end

  @doc """
  Generate a entrant.
  """
  def entrant_fixture(attrs \\ %{}) do
    {:ok, entrant} =
      attrs
      |> Enum.into(%{
        ticket: "some ticket",
        winner: true
      })
      |> PrizeDraw.DrawContext.create_entrant()

    entrant
  end
end
