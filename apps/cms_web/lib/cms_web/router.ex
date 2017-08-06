defmodule CmsWeb.Router do
  use CmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    
    plug CmsWeb.Locale, "fr"
  end
  
  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  
  scope "/", CmsWeb do
    pipe_through [:browser, :browser_session]
    
    get "/", PageController, :index
    
    get "/sign_in", SessionController, :new, as: :sign_in
    delete "/sign_out/:id", SessionController, :delete, as: :sign_out
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    
    resources "/users", UserController
    resources "/posts", PostController
  end
  
  # Other scopes may use custom stacks.
  # scope "/api", CmsWeb do
  #   pipe_through :api
  # end
end
