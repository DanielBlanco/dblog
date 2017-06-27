defmodule Dblog.Mixfile do
  use Mix.Project

  def project do
    [app: :dblog,
     version: "0.0.#{committed_at()}",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Unix timestamp of the last commit.
  def committed_at do
    System.cmd("git", ~w[log -1 --date=short --pretty=format:%ct]) |> elem(0)
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Dblog, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger,
                    :gettext, :phoenix_ecto, :postgrex, :guardian, :comeonin,
                    :cors_plug, :secure_random, :hackney, :poison, :timex,
                    :timex_ecto]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:cowlib, "~> 1.0"},
      {:cors_plug, "~> 1.1"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:comeonin, "~> 2.5"},
      {:poison, "~> 3.1", override: true}, # just until phoenix supports it.
      {:ex_machina, "~> 2.0", only: :test},
      {:secure_random, "~> 0.2"},
      {:guardian, "~> 0.14.0"},
      {:distillery, "~> 1.0"},
      {:hackney, "~> 1.6"},
      {:timex, "~> 3.0"},
      {:timex_ecto, "~> 3.0"},
      {:ex_utils, "~> 0.1.6"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
