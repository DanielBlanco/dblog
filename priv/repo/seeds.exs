# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dblog.Repo.insert!(%Dblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Dblog.Accounts

%{
  id: "28af3599-4929-4754-906c-e0e08f8763ff",
  name: "Daniel Blanco"
}
|> Accounts.create_user()
