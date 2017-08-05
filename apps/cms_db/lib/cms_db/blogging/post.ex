defmodule CmsDb.Blogging.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__
  alias CmsDb.Accounting.User
  
  schema "posts" do
    field :title, :string
    field :body, :binary
    belongs_to :user, User
        
    timestamps()
  end

  @required_fields ~w(title body)a
  
  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
