# Contains authentication logic helpers
# For views and controller

defmodule CmsWeb.SharedHelpers do
  def logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end
  
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end