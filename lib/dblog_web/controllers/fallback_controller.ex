defmodule DblogWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DblogWeb, :controller

  def call(conn, {:error, _, %Ecto.Changeset{} = changeset, _}) do
    call(conn, {:error, changeset})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(DblogWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(DblogWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(ImpressWeb.ErrorView, "401.json")
  end

  def call(conn, {:error, :no_session}) do
    unauthenticated!(conn, [])
  end

  @doc """
  Called if the user was not able to authenticate.
  """
  def unauthenticated(conn, params) do
    unauthenticated!(conn, params)
  end
end
