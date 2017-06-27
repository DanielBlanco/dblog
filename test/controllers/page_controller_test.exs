defmodule Dblog.PageControllerTest do
  use Dblog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "elm-target"
  end
end
