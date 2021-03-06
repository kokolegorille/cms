defmodule CmsWeb.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias CmsDb.Accounting
  alias CmsDb.Accounting.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Accounting.get_user(String.to_integer(id)) }
  def from_token(_), do: { :error, "Unknown resource type" }
end