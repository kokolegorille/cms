defmodule Cms.Application do
  @moduledoc """
  The Cms Application Service.

  The cms system business domain lives in this application.

  Exposes API to clients such as the `CmsWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      
    ], strategy: :one_for_one, name: Cms.Supervisor)
  end
end
