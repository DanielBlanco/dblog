defmodule Dblog.Factory do
  use ExMachina.Ecto, repo: Dblog.Repo

  alias Dblog.User

  def user_factory do
    %User{
      name: "Test #{rand()}",
      password: "zuperzekret",
      password_hash: hash_password("zuperzekret"),
      email: sequence(:email, &"email-#{&1}@test.com")
    }
  end

  # Generates a random string
  defp rand do
    Base.encode16(:crypto.strong_rand_bytes(8))
  end

  defp hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
