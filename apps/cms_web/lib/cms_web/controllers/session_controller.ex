defmodule CmsWeb.SessionController do
  use CmsWeb, :controller
  alias CmsDb.Accounting
  
  def new(conn, _params) do
    render conn, "new.html"
  end
  
  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case Accounting.authenticate(%{"name" => name, "password" => password}) do
      {:ok, user} ->
        conn 
        |> put_flash(:info, "Welcome back #{user.name}!")
        |> redirect(to: page_path(conn, :index))
      {:error, reason} ->
        conn 
        |> put_flash(:error, reason)
        |> render("new.html")
    end
  end
  
  def delete(conn, _params) do
    
  end
end