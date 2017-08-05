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
  
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
  
  ## Authentication
  
  def authenticate(%{"name" => name, "password" => password}) do
    user = get_user_by_name!(name)
    
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, "Invalid username/password combination."}
    end
  end
  
  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end