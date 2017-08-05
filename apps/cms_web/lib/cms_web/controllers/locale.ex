defmodule CmsWeb.Locale do
  import Plug.Conn
  
  @locales ["en", "fr"]
  @default_locale "fr"
  
  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _opts) 
    when locale in @locales, 
    do: set_locale(conn, locale)
  
  def call(conn, _opts) do
    locale = get_session(conn, :locale) || @default_locale
    set_locale(conn, locale)
  end
  
  # PRIVATE
  
  defp set_locale(conn, locale) do
    Gettext.put_locale(CmsWeb.Gettext, locale)
    conn |> put_session(:locale, locale)
  end
end
