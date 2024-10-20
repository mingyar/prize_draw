defmodule PrizeDrawWeb.EntrantControllerTest do
  use PrizeDrawWeb.ConnCase

  import PrizeDraw.DrawContextFixtures

  alias PrizeDraw.DrawContext.Entrant

  @create_attrs %{
    ticket: "some ticket",
    winner: true
  }
  @update_attrs %{
    ticket: "some updated ticket",
    winner: false
  }
  @invalid_attrs %{ticket: nil, winner: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entrants", %{conn: conn} do
      conn = get(conn, Routes.entrant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entrant" do
    test "renders entrant when data is valid", %{conn: conn} do
      conn = post(conn, Routes.entrant_path(conn, :create), entrant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.entrant_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ticket" => "some ticket",
               "winner" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entrant_path(conn, :create), entrant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update entrant" do
    setup [:create_entrant]

    test "renders entrant when data is valid", %{conn: conn, entrant: %Entrant{id: id} = entrant} do
      conn = put(conn, Routes.entrant_path(conn, :update, entrant), entrant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.entrant_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ticket" => "some updated ticket",
               "winner" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, entrant: entrant} do
      conn = put(conn, Routes.entrant_path(conn, :update, entrant), entrant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete entrant" do
    setup [:create_entrant]

    test "deletes chosen entrant", %{conn: conn, entrant: entrant} do
      conn = delete(conn, Routes.entrant_path(conn, :delete, entrant))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.entrant_path(conn, :show, entrant))
      end
    end
  end

  defp create_entrant(_) do
    entrant = entrant_fixture()
    %{entrant: entrant}
  end
end
