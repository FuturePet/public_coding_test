# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :go_fetch,
  ecto_repos: [GoFetch.Repo]

config :go_fetch, GoFetch.Repo, database: "gofetch.db"

# Configures the endpoint
config :go_fetch, GoFetchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L+Ijklfu4oGzBYU25Cd+eOYHV03YTTL4M4h/Z8+AM9rmEYn0s/+CSTgq7Zzq9SSV",
  render_errors: [view: GoFetchWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GoFetch.PubSub,
  live_view: [signing_salt: "Hasno4ws"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(./js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :dart_sass,
  version: "1.49.11",
  default: [
    args: ~w(./css/app.scss ../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
