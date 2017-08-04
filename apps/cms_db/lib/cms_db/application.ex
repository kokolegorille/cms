defmodule CmsDb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc """
  The CmsDb Application Service.

  The cms_db system business domain lives in this application.

  Exposes API to clients such as the `CmsWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: CmsDb.Worker.start_link(arg)
      # {CmsDb.Worker, arg},
      
      supervisor(CmsDb.Repo, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CmsDb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
