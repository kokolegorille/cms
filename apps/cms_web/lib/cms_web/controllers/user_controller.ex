defmodule CmsWeb.UserController do
  use CmsWeb, :controller
  alias __MODULE__
  alias CmsDb.Accounting
  alias CmsDb.Accounting.User
  
  plug Guardian.Plug.EnsureAuthenticated, handler: UserController
  
  def index(conn, _params) do
    users = Accounting.list_users()
    render conn, "index.html", users: users
  end
  
  def show(conn, %{"id" => id}) do
    user = Accounting.get_user!(id)
    render(conn, "show.html", user: user)
  end
  
  def new(conn, _params) do
    changeset = Accounting.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end
  
  def create(conn, %{"user" => user_params}) do
    case Accounting.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  
  def edit(conn, %{"id" => id}) do
    user = Accounting.get_user!(id)
    changeset = Accounting.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounting.get_user!(id)

    case Accounting.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounting.get_user!(id)
    {:ok, _user} = Accounting.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
    
  # handle the case where no authenticated user
  # was found
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required.")
    |> redirect(to: "/sessions/new")
    |> halt()
  end
end