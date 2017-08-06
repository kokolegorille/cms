defmodule CmsDb.Blogging do
  import Ecto.Query, warn: false
  
  alias CmsDb.Repo
  alias CmsDb.Blogging.Post

  ## Post
  
  def list_posts(user), do: Repo.all(user_posts(user))
  
  def get_post(user, id), do: Repo.get(user_posts(user), id)
  
  def create_post(user, attrs \\ %{}) do
    build_post(user, attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    change_post(post, attrs)
    |> Repo.update()
  end
  
  def delete_post(%Post{} = post), do: Repo.delete(post)

  def build_post(user, attrs) do
    user
    |> Ecto.build_assoc(:posts)
    |> Post.changeset(attrs)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
  
  # PRIVATE
  
  defp user_posts(user), do: Ecto.assoc(user, :posts)
end