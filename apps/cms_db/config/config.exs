use Mix.Config

config :cms_db, ecto_repos: [CmsDb.Repo]

import_config "#{Mix.env}.exs"
