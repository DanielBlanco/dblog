defmodule DblogWeb.Resolvers.Accounts do
  alias Dblog.Accounts

  def list_users(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def get_user(_parent, %{id: id}, _resolution) do
    case Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end
end
