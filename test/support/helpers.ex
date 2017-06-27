defmodule Dblog.Helpers do
  @doc"""
  Shift the time from now using Timex.
  """
  def ecto_time_shift(shift_options) do
    Timex.now() |> Timex.shift(shift_options)
  end
end
