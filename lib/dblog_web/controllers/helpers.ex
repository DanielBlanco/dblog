defmodule DblogWeb.Controller.Helpers do
  @moduledoc """
  Conveniences for managing controllers.
  """
  import Phoenix.Controller
  alias DblogWeb.ErrorView


  @doc """
  Returns the current user.

  TODO: Add some real code to fetch the current user.
  """
  def current_user(_conn) do
    Dblog.Accounts.get_user! "28af3599-4929-4754-906c-e0e08f8763ff"
  end

  @doc """
  Returns the current author.
  """
  def current_author(conn) do
    conn.assigns.current_author
  end

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
