defmodule CmsWeb.PostView do
  use CmsWeb, :view
  
  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end
end