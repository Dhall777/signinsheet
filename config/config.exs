# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :signinsheet,
  ecto_repos: [Signinsheet.Repo]

# Configures the endpoint
config :signinsheet, SigninsheetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eNQTdG22YYcxpL1DoWlN6TsfQhaEpVkyqtLgRZod6Adtu58nMG2m6Eec4ZeK8lom",
  render_errors: [view: SigninsheetWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Signinsheet.PubSub,
  live_view: [signing_salt: "dfMbGWW0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
