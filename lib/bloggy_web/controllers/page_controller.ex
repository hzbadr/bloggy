defmodule BloggyWeb.PageController do
  use BloggyWeb, :controller
  alias Bloggy.Content

  def index(conn, _params) do
    articles = Content.list_articles()
    render(conn, "index.html", articles: articles)
  end
end
