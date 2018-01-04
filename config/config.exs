# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bloggy,
  ecto_repos: [Bloggy.Repo]

# Configures the endpoint
config :bloggy, BloggyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XX0mUAZCyglZf1gbsuC4yTPSuIWabpl6az878DS3fIQgimP1ukM4w2Dcr6p9wd0E",
  render_errors: [view: BloggyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bloggy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Bloggy.Coherence.User,
  repo: Bloggy.Repo,
  module: Bloggy,
  web_module: BloggyWeb,
  router: BloggyWeb.Router,
  messages_backend: BloggyWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable]

config :coherence, BloggyWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
