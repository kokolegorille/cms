defmodule CmsWeb.LayoutView do
  use CmsWeb, :view
  
  def logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end
  
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
