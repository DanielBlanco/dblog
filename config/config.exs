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

# Allows you to tailor how the JWT (JSON Web Token) generation behaves.
#
# allowed_algos - The list of algorithms (must be compatible with JOSE). The
#                 first is used as the encoding key. Default is: ["HS512"].
# verify_module - Provides a mechanism to setup your own validations for items
#                 in the token. Default is Guardian.JWT.
# issuer        - The entry to put into the token as the issuer. This can be
#                 used in conjunction with verify_issuer.
# ttl           - The default ttl of a token.
# allowed_drift - The allowable drift in miliseconds to allow for time fields.
#                 Allows for dealing with clock skew
# verify_issuer - If set to true, the issuer will be verified to be the same
#                 issuer as specified in the issuer field
# secret_key    - The key to sign the tokens. See below for examples.
# serializer    - The serializer that serializes the 'sub' (Subject) field into
#                 and out of the token.
#
# TODO: Change the secret_key to something fetched from ENV.
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "DBlog",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "hRhFmwOfWggIsqIhAUubDW15VzThjP6IjYXesnvwF1rQID8FPObcR0n47AhUkerL",
  serializer: DBlog.GuardianSerializer,
  permissions: %{
    default: [:read, :write]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
