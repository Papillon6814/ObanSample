# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :oban_sample,
  ecto_repos: [ObanSample.Repo]

# Configures the endpoint
config :oban_sample, ObanSampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xzzTtg5swu8eTw2g75oqMz5ox4ILQkgfKOk56vdVIAsVZrCr6VaW37sYaqyyBx6X",
  render_errors: [view: ObanSampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ObanSample.PubSub,
  live_view: [signing_salt: "FPA53ZJY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :oban_sample, Oban,
  repo: ObanSample.Repo,
  plugins: [
    Oban.Plugins.Pruner,
    {Oban.Plugins.Cron,
    crontab: [
      {"* * * * *", ObanSample.Cron}
    ]}
  ],
  queues: [default: 10, events: 50, media: 20]
