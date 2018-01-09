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
alias Dblog.Repo
alias Dblog.Accounts
alias Dblog.Accounts.User
alias Dblog.Blog

{:ok, dblanco} =
  case User |> Repo.get("28af3599-4929-4754-906c-e0e08f8763ff") do
    nil ->
      %{
        id: "28af3599-4929-4754-906c-e0e08f8763ff",
        name: "Daniel Blanco"
      }
      |> Accounts.create_user()

    user ->
      {:ok, user}
  end

# Create 10 seed users
for _ <- 1..10 do
  %{ name: Faker.Name.name }
  |> Accounts.create_user()
end

# Create dblanco_author
dblanco_author = dblanco |> IO.inspect |> Blog.get_or_create_author!()

# Create 40 seed posts
for _ <- 1..40 do
  dblanco_author
  |> Blog.create_post(%{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.sentences(%Range{first: 1, last: 3}) |> Enum.join("\n\n")
  })
end
