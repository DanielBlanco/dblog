defmodule DblogWeb.Schema.Middleware.BinaryId do
  @doc """
  GraphQL binary id checker.
  """
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.arguments do
      %{id: id} ->
        resolution |> validate_uuid(id)
      _ ->
        resolution
    end
  end

  defp validate_uuid(resolution, id) do
    case UUID.info(id) do
      {:error, _} ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "ID #{id} not found"})
      _ ->
        resolution
    end
  end

end
