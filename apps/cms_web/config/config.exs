# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cms_web,
  namespace: CmsWeb

# Configures the endpoint
config :cms_web, CmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vMR7ur3vXGhl65nA533yVGw6MS8H5olq9N1f1RB7kOa5N/Z+CxJYJmDNPIeNCTle",
  render_errors: [view: CmsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CmsWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cms_web, :generators,
  context_app: :cms

# Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "CmsWeb",
  ttl: { 7, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  # generated with 
  # $ mix phx.gen.secret
  secret_key: "9clB3mXxHdd8MuHAnR8cLS4V8BIQ7nVW/AoJhri5P2O9fCjA+b//EL/C7xhcpxfu",
  serializer: CmsWeb.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
