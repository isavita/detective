# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :detective,
  ecto_repos: [Detective.Repo]

# Configures the endpoint
config :detective, DetectiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "73LxuMyo2Is101DNgskfxguakSbF1sLotoRz7601xpFqjYTLnYDd7T40npHYzlDd",
  render_errors: [view: DetectiveWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Detective.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
