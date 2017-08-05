defmodule CmsWeb.Locale do
  import Plug.Conn
  
  # @locales ["en", "fr"]
  
  def init(default), do: default

  def call(conn, _opts) do
    case conn.params["locale"] || get_session(conn, :locale) do
      nil     -> conn
      locale  ->
        Gettext.put_locale(CmsWeb.Gettext, locale)
        conn |> put_session(:locale, locale)
    end
  end
  
  # def call(conn, _opts) do
  #   case conn.params["locale"] || get_session(conn, :locale) do
  #     nil     -> conn
  #     locale  ->
  #       Gettext.put_locale(CmsWeb.Gettext, locale)
  #       conn |> put_session(:locale, locale)
  #   end
  # end
  
  # def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
  #   assign(conn, :locale, loc)
  # end
  # def call(conn, default), do: assign(conn, :locale, default)
end
