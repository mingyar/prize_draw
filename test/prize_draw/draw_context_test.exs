defmodule PrizeDraw.DrawContextTest do
  use PrizeDraw.DataCase

  alias PrizeDraw.DrawContext

  describe "draws" do
    alias PrizeDraw.DrawContext.Draw

    import PrizeDraw.DrawContextFixtures

    @invalid_attrs %{date: nil, name: nil}

    test "list_draws/0 returns all draws" do
      draw = draw_fixture()
      assert DrawContext.list_draws() == [draw]
    end

    test "get_draw!/1 returns the draw with given id" do
      draw = draw_fixture()
      assert DrawContext.get_draw!(draw.id) == draw
    end

    test "create_draw/1 with valid data creates a draw" do
      valid_attrs = %{date: ~D[2023-01-11], name: "some name"}

      assert {:ok, %Draw{} = draw} = DrawContext.create_draw(valid_attrs)
      assert draw.date == ~D[2023-01-11]
      assert draw.name == "some name"
    end

    test "create_draw/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DrawContext.create_draw(@invalid_attrs)
    end

    test "update_draw/2 with valid data updates the draw" do
      draw = draw_fixture()
      update_attrs = %{date: ~D[2023-01-12], name: "some updated name"}

      assert {:ok, %Draw{} = draw} = DrawContext.update_draw(draw, update_attrs)
      assert draw.date == ~D[2023-01-12]
      assert draw.name == "some updated name"
    end

    test "update_draw/2 with invalid data returns error changeset" do
      draw = draw_fixture()
      assert {:error, %Ecto.Changeset{}} = DrawContext.update_draw(draw, @invalid_attrs)
      assert draw == DrawContext.get_draw!(draw.id)
    end

    test "delete_draw/1 deletes the draw" do
      draw = draw_fixture()
      assert {:ok, %Draw{}} = DrawContext.delete_draw(draw)
      assert_raise Ecto.NoResultsError, fn -> DrawContext.get_draw!(draw.id) end
    end

    test "change_draw/1 returns a draw changeset" do
      draw = draw_fixture()
      assert %Ecto.Changeset{} = DrawContext.change_draw(draw)
    end
  end

  describe "users" do
    alias PrizeDraw.DrawContext.User

    import PrizeDraw.DrawContextFixtures

    @invalid_attrs %{draw_id: nil, email: nil, name: nil, password_hash: nil, winner: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert DrawContext.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert DrawContext.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{draw_id: 42, email: "some email", name: "some name", password_hash: "some password_hash", winner: true}

      assert {:ok, %User{} = user} = DrawContext.create_user(valid_attrs)
      assert user.draw_id == 42
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.winner == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DrawContext.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{draw_id: 43, email: "some updated email", name: "some updated name", password_hash: "some updated password_hash", winner: false}

      assert {:ok, %User{} = user} = DrawContext.update_user(user, update_attrs)
      assert user.draw_id == 43
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.winner == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = DrawContext.update_user(user, @invalid_attrs)
      assert user == DrawContext.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = DrawContext.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> DrawContext.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = DrawContext.change_user(user)
    end
  end
end
