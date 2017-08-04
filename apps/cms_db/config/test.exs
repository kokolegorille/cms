use Mix.Config

# Configure your database
config :dummy, CmsDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cms_db_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox