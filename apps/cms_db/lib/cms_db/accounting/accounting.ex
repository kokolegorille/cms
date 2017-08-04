defmodule CmsDb.Accounting do
  import Ecto.Query, warn: false
  
  alias CmsDb.Repo
  alias CmsDb.Accounting.User
  
  ## User
  
  def list_users, do: Repo.all(User)
  
  def get_user!(id), do: Repo.get!(User, id)
  
  def get_user_by_name!(name), do: Repo.get_by(User, name: name)
  
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
  
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
  
  def delete_user(%User{} = user), do: Repo.delete(user)
end