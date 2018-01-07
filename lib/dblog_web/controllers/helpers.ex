defmodule DblogWeb.Controller.Helpers do
  @moduledoc """
  Conveniences for managing controllers.
  """
  import Phoenix.Controller
  alias DblogWeb.ErrorView

  @doc """
  Raises a 403 error.
  """
  def forbidden!(conn) do
    conn
    |> Plug.Conn.put_status(403)
    |> put_view(ErrorView)
    |> render("403.json", [])
  end

  @doc """
  Called if the user was not able to authenticate.
  """
  def unauthenticated!(conn, _params) do
    conn
    |> Plug.Conn.put_status(401)
    |> put_view(ErrorView)
    |> render("401.json", [])
  end

end
