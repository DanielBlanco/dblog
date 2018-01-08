defmodule Dblog.Factory do
  use ExMachina.Ecto, repo: Dblog.Repo

  # --- ACCOUNTS

  def user_factory do
    %Dblog.Accounts.User{
      id: uuid(),
      name: sequence("Akali"),
      active: true
    }
  end

  # --- BLOG

  def author_factory do
    %Dblog.Blog.Author{
      id: uuid(),
      bio: "cool guy",
      user: build(:user)
    }
  end

  def post_factory do
    %Dblog.Blog.Post{
      id: uuid(),
      title: sequence("interesting topic"),
      body: "about the interesting topic",
      author: build(:author)
    }
  end

  # ---- HELPERS

  # def hash_user_password(user) do
  #   %{ user | password_hash: hash_password(user.password) }
  # end

  # def one_month_ago do
  #   {:ok, ecto_dt} = Timex.now |> Timex.shift(months: -1) |> Ecto.DateTime.cast()
  #   ecto_dt
  # end

  # def now do
  #   {:ok, ecto_dt} = Timex.now |> Ecto.DateTime.cast()
  #   ecto_dt
  # end

  # Generates a random string
  # defp rand do
  #   Base.encode16(:crypto.strong_rand_bytes(8))
  # end

  # defp hash_password(password) do
  #   Comeonin.Argon2.hashpwsalt(password)
  # end

  defp uuid, do: UUID.uuid4()
end
