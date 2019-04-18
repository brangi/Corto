# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :corto,
  ecto_repos: [Corto.Repo.Mnesia]

# Configures the endpoint
config :corto, CortoWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  secret_key_base: "JxjtZPXDRTady5IDPd8GxST5jrZxpITw/7qCl5isa3oYmcPz1W0P0yMahFsUzH0K",
  render_errors: [view: CortoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Corto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configure your database
config :corto, Corto.Repo.Mnesia,
  adapter: EctoMnesia.Adapter

config :ecto_mnesia,
  host: {:system, :atom, "MNESIA_HOST", Kernel.node()},
  storage_type: {:system, :atom, "MNESIA_STORAGE_TYPE", :disc_copies}

config :mnesia,
       dir: 'mnesia-data'

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
