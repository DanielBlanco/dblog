use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dblog, DblogWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Hashing passswords is intentionally expensive. Doing this extra bit of work
# makes our passwords harder to crack, but we don't need all of that security in
# the test environment. So we are easing up the number of hashing rounds to
# speed up our test suite.
config :argon2_elixir, t_cost: 1, m_cost: 8

# Finally import the config/test.secret.exs
# which should be versioned separately.
import_config "test.secret.exs"
