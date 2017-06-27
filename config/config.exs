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
config :dblog, Dblog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZeZoyf4nGLkRM6aPzfoxtZBkp89snjhzZIUxFc6QQV3LJbC77I3YkZgFF30AP4XQ",
  render_errors: [view: Dblog.ErrorView, accepts: ~w(html json)],
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
  allowed_algos: ["ES512"],
  verify_module: Guardian.JWT,
  issuer: "DBR",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: %{
    "alg" => "ES512",
    "crv" => "P-521",
    "d" => "AVDuOBokicU-yXj4zNwrK-29vmUvmOBNxHB-7_PgRO6e3VKTl-wuUmPEQnHtG_GYoC0cUHAJtpGlaeGF1mIRpeSk",
    "kty" => "EC",
    "use" => "sig",
    "x" => "ANT4yNLVHCeYtQOpjbhuXnoB69C4VoWLESxxbnEKt8W8BTL_7kdqUcCMBxxQvPhrf3fmliosAxb1BcspPtV4aofP",
    "y" => "AAPlYHP2qGpubv_qzYbNvMOxJUOuypaVeEYV6NnEtWpW2jHupr5xMaINDXgpN1CDwddZxQ-WpE4jQEl8onXD9_su"
  },
  serializer: Dblog.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
