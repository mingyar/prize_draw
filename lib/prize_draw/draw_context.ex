defmodule PrizeDraw.DrawContext do
  @moduledoc """
  The DrawContext context.
  """

  import Ecto.Query, warn: false
  alias PrizeDraw.Repo

  alias PrizeDraw.DrawContext.Draw

  @doc """
  Returns the list of draws.

  ## Examples

      iex> list_draws()
      [%Draw{}, ...]

  """
  def list_draws do
    Repo.all(Draw)
  end

  @doc """
  Gets a single draw.

  Raises `Ecto.NoResultsError` if the Draw does not exist.

  ## Examples

      iex> get_draw!(123)
      %Draw{}

      iex> get_draw!(456)
      ** (Ecto.NoResultsError)

  """
  def get_draw!(id) do
    Draw
    |> preload(:entrants)
    |> Repo.get!(id)
  end

  @doc """
  Creates a draw.

  ## Examples

      iex> create_draw(%{field: value})
      {:ok, %Draw{}}

      iex> create_draw(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_draw(attrs \\ %{}) do
    %Draw{}
    |> Draw.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a draw.

  ## Examples

      iex> update_draw(draw, %{field: new_value})
      {:ok, %Draw{}}

      iex> update_draw(draw, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_draw(%Draw{} = draw, attrs) do
    draw
    |> Draw.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a draw.

  ## Examples

      iex> delete_draw(draw)
      {:ok, %Draw{}}

      iex> delete_draw(draw)
      {:error, %Ecto.Changeset{}}

  """
  def delete_draw(%Draw{} = draw) do
    Repo.delete(draw)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking draw changes.

  ## Examples

      iex> change_draw(draw)
      %Ecto.Changeset{data: %Draw{}}

  """
  def change_draw(%Draw{} = draw, attrs \\ %{}) do
    Draw.changeset(draw, attrs)
  end

  alias PrizeDraw.DrawContext.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias PrizeDraw.DrawContext.Entrant

  @doc """
  Returns the list of entrants.

  ## Examples

      iex> list_entrants()
      [%Entrant{}, ...]

  """
  def list_entrants do
    Repo.all(Entrant)
  end

  def list_entrants_by_draw(draw_id) do
    Entrant
    |> where([u], u.draw_id == ^draw_id)
    |> preload(:user)
    |> Repo.all()
  end

  @doc """
  Gets a single entrant.

  Raises `Ecto.NoResultsError` if the Entrant does not exist.

  ## Examples

      iex> get_entrant!(123)
      %Entrant{}

      iex> get_entrant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entrant!(id), do: Repo.get!(Entrant, id)

  @doc """
  Creates a entrant.

  ## Examples

      iex> create_entrant(%{field: value})
      {:ok, %Entrant{}}

      iex> create_entrant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entrant(attrs \\ %{}) do
    %Entrant{}
    |> Entrant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entrant.

  ## Examples

      iex> update_entrant(entrant, %{field: new_value})
      {:ok, %Entrant{}}

      iex> update_entrant(entrant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entrant(%Entrant{} = entrant, attrs) do
    entrant
    |> Entrant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entrant.

  ## Examples

      iex> delete_entrant(entrant)
      {:ok, %Entrant{}}

      iex> delete_entrant(entrant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entrant(%Entrant{} = entrant) do
    Repo.delete(entrant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entrant changes.

  ## Examples

      iex> change_entrant(entrant)
      %Ecto.Changeset{data: %Entrant{}}

  """
  def change_entrant(%Entrant{} = entrant, attrs \\ %{}) do
    Entrant.changeset(entrant, attrs)
  end
end
