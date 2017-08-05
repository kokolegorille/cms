defmodule CmsWeb.SessionController do
  use CmsWeb, :controller
  alias __MODULE__
  alias CmsDb.Accounting
    
  plug :scrub_params, "session" when action in [:create]
  plug Guardian.Plug.EnsureAuthenticated, [handler: SessionController] 
    when action in [:delete]
  
  def new(conn, _params) do
    render conn, "new.html"
  end
  
  def create(conn, %{"session" => %{"name" => name, "password" => password}}) 
    when not is_nil(name) and not is_nil(password) do
    case Accounting.authenticate(%{"name" => name, "password" => password}) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Welcome back %{name}!", name: user.name))
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))
      {:error, _reason} ->
        render_error(conn)
    end
  end
  
  def create(conn, _params) do
    render_error(conn)
  end
  
  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, gettext("Logged out successfully."))
    |> redirect(to: page_path(conn, :index))
  end
  
  # PRIVATE
  
  defp render_error(conn) do
    conn
    |> put_flash(:error, gettext("Invalid username/password combination."))
    |> render("new.html")
  end
end