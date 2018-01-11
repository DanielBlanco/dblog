defmodule DblogWeb.Schema.Middleware.Authentication do
  @doc """
  Verifies a currrent user exists.
  """
  @behaviour Absinthe.Middleware

  def call(%{context: %{current_user: _}} = resolution, _config) do
    resolution
  end

  def call(resolution, _config) do
    resolution
    |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
  end
end
