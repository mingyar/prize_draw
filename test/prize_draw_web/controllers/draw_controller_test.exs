defmodule PrizeDrawWeb.DrawControllerTest do
  use PrizeDrawWeb.ConnCase

  import PrizeDraw.DrawContextFixtures

  alias PrizeDraw.DrawContext.Draw

  @create_attrs %{
    date: ~D[2023-01-11],
    name: "some name"
  }
  @update_attrs %{
    date: ~D[2023-01-12],
    name: "some updated name"
  }
  @invalid_attrs %{date: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all draws", %{conn: conn} do
      conn = get(conn, Routes.draw_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create draw" do
    test "renders draw when data is valid", %{conn: conn} do
      conn = post(conn, Routes.draw_path(conn, :create), draw: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.draw_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2023-01-11",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.draw_path(conn, :create), draw: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update draw" do
    setup [:create_draw]

    test "renders draw when data is valid", %{conn: conn, draw: %Draw{id: id} = draw} do
      conn = put(conn, Routes.draw_path(conn, :update, draw), draw: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.draw_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2023-01-12",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, draw: draw} do
      conn = put(conn, Routes.draw_path(conn, :update, draw), draw: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete draw" do
    setup [:create_draw]

    test "deletes chosen draw", %{conn: conn, draw: draw} do
      conn = delete(conn, Routes.draw_path(conn, :delete, draw))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.draw_path(conn, :show, draw))
      end
    end
  end

  defp create_draw(_) do
    draw = draw_fixture()
    %{draw: draw}
  end
end
