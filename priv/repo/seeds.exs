# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dblog.Repo.insert!(%Dblog.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Dblog.Repo
alias Dblog.Post

Repo.insert!(%Post{title: "Post 1", published_at: Timex.now()})
Repo.insert!(%Post{title: "Post 2", published_at: Timex.now()})
Repo.insert!(%Post{title: "Post 3", published_at: Timex.now()})
