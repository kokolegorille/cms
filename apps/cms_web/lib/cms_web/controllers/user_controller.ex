defmodule CmsWeb.UserController do
  use CmsWeb, :controller
  alias __MODULE__
  
  plug Guardian.Plug.EnsureAuthenticated, handler: UserController
  
  def index(conn, _params) do
    render conn, "index.html"
  end
  
  # def show(conn, _params) do
  #
  # end
  
  def new(conn, _params) do
    render conn, "new.html"
  end
  
  # def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
  #   # case Accounting.authenticate(%{"name" => name, "password" => password}) do
  #   #   {:ok, user} ->
  #   #     conn
  #   #     |> put_flash(:info, "Welcome back #{user.name}!")
  #   #     |> redirect(to: page_path(conn, :index))
  #   #   {:error, reason} ->
  #   #     conn
  #   #     |> put_flash(:error, reason)
  #   #     |> render("new.html")
  #   # end
  # end
  #
  # def edit(conn, _params) do
  #
  # end
  #
  # def update(conn, _params) do
  #
  # end
  #
  # def delete(conn, _params) do
  #
  # end
  
  # handle the case where no authenticated user
  # was found
  def unauthenticated(conn, params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: "/sessions/new")
    |> halt()
  end
end