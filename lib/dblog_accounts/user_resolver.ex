defmodule Dblog.Accounts.UserResolver do
  alias Dblog.Accounts

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end
end
