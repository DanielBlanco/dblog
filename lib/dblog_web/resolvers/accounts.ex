defmodule DblogWeb.Resolvers.Accounts do
  alias Dblog.Accounts

  def list_users(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def get_user(_parent, %{id: id}, _resolution) do
    find_user(id)
  end

  @doc """
  TODO: Only allow current_user to update his data.
  """
  def update_user(_parent, %{id: id, user: user_params}, _) do
    with {:ok, user} <- find_user(id) do
      Accounts.update_user(user, update_user_params(user_params))
    else
      {:error, error} -> {:error, error}
      _ -> {:error, "Something bad happened"}
    end
  end

  defp find_user(id) do
    case Accounts.get_user(id) do
      nil ->
        not_found(id)

      user ->
        {:ok, user}
    end
  end

  defp not_found(id) do
    {:error, "ID #{id} not found"}
  end

  defp update_user_params(params) do
    case params[:email] do
      nil ->
        params

      _ ->
        params
        |> Map.put(:credential, %{
          email: params[:email],
          password: params[:password]
        })
    end
    |> Map.drop([:email, :password])
  end

end
