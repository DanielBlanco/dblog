# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dblog,
  ecto_repos: [Dblog.Repo]

# Configures the endpoint
config :dblog, DblogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v6XIzeEVe7kRt017n40l4EOi3U055SXMdva6ObMY2pj5X6paxj/Vu0zhLFgV/1ce",
  render_errors: [view: DblogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dblog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
