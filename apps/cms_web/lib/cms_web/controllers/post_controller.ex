defmodule CmsWeb.PostController do
  use CmsWeb, :controller
  alias __MODULE__
  alias CmsDb.Blogging
  alias CmsDb.Blogging.Post
  
  plug Guardian.Plug.EnsureAuthenticated, handler: PostController
  
  def index(conn, _params) do
    posts = Blogging.list_posts()
    render conn, "index.html", posts: posts
  end
  
  def show(conn, %{"id" => id}) do
    post = Blogging.get_post(id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Blogging.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  # def create(conn, %{"user" => user_params}) do
  #   case Accounting.create_user(user_params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, gettext("User created successfully."))
  #       |> redirect(to: user_path(conn, :show, user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
  #
  # def edit(conn, %{"id" => id}) do
  #   user = Accounting.get_user(id)
  #   changeset = Accounting.change_user(user)
  #   render(conn, "edit.html", user: user, changeset: changeset)
  # end
  #
  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounting.get_user(id)
  #
  #   case Accounting.update_user(user, user_params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, gettext("User updated successfully."))
  #       |> redirect(to: user_path(conn, :show, user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", user: user, changeset: changeset)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   user = Accounting.get_user(id)
  #   {:ok, _user} = Accounting.delete_user(user)
  #
  #   conn
  #   |> put_flash(:info, gettext("User deleted successfully."))
  #   |> redirect(to: user_path(conn, :index))
  # end
    
  # handle the case where no authenticated user
  # was found
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, gettext("You must be signed in to access that page."))
    |> redirect(to: sign_in_path(conn, :new))
    |> halt()
  end
end