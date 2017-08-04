use Mix.Config

# Configure your database
config :cms_db, CmsDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cms_db_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10