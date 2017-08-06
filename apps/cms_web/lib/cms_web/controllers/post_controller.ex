defmodule CmsWeb.PostController do
  use CmsWeb, :controller
  alias __MODULE__
  alias CmsDb.Blogging
  alias CmsDb.Blogging.Post
  
  plug Guardian.Plug.EnsureAuthenticated, handler: PostController
  
  def action(conn, _) do
    apply(PostController, action_name(conn), 
      [conn, conn.params, current_user(conn)])
  end
  
  def index(conn, _params, user) do
    posts = Blogging.list_posts(user)
    render conn, "index.html", posts: posts
  end
  
  def show(conn, %{"id" => id}, user) do
    post = Blogging.get_post(user, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params, user) do
    changeset = Blogging.build_post(user, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}, user) do
    case Blogging.create_post(user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, gettext("Post created successfully."))
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}, user) do
    post = Blogging.get_post(user, id)
    changeset = Blogging.change_post(post)
    
    render(conn, "edit.html", post: post, changeset: changeset)
  end
  
  def update(conn, %{"id" => id, "post" => post_params}, user) do
    post = Blogging.get_post(user, id)
    changeset = Blogging.change_post(post, post_params)
    
    case Blogging.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    post = Blogging.get_post(user, id)
    {:ok, _video} = Blogging.delete_post(post)

    conn
    |> put_flash(:info, gettext("Post deleted successfully."))
    |> redirect(to: post_path(conn, :index))
  end
    
  # handle the case where no authenticated user
  # was found
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, gettext("You must be signed in to access that page."))
    |> redirect(to: sign_in_path(conn, :new))
    |> halt()
  end
end