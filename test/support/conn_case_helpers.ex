defmodule DblogWeb.ConnCase.Helpers do
  # import Dblog.Factory

  # Seeds Daniel Blanco user.
  def insert_dblanco do
    %{
      id: "28af3599-4929-4754-906c-e0e08f8763ff",
      name: "Daniel Blanco"
    }
    |> Dblog.Accounts.create_user()
  end

  # Just in case.
  def get_dblanco! do
    Dblog.Accounts.get_user!("28af3599-4929-4754-906c-e0e08f8763ff")
  end

  def render_json(view, template, assigns) do
    view.render(template, assigns) |> format_json
  end

  # defp authorize_token(conn, jwt) do
  #   conn |> Plug.Conn.put_req_header("authorization", "Bearer #{jwt}")
  # end

  defp format_json(data) do
    data |> Poison.encode! |> Poison.decode!
  end

  def parse_iso_date!(date) do
    Timex.parse!(date, "{ISO:Extended:Z}")
  end

  def json_date_format!(nil), do: nil
  def json_date_format!(date), do: Timex.format!(date, "{ISO:Extended:Z}")
end
