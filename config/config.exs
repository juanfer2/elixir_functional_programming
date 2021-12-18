# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_in_action,
  ecto_repos: [ElixirInAction.Repo]

# Configures the endpoint
config :elixir_in_action, ElixirInActionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mKcemX15KSsnT+CS+0wYt64bmCCU0mZEdGlTkfDid3ywsR3h1cfxxAaKIXcejMUS",
  render_errors: [view: ElixirInActionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirInAction.PubSub,
  live_view: [signing_salt: "fYEMcq/m"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
