defmodule BloggyWeb.PageController do
  use BloggyWeb, :controller
  alias Bloggy.Content

  def index(conn, _params) do
    current_user = Coherence.current_user(conn)
    if current_user do
      articles = Content.list_articles_with_likes(current_user.id)
    else
      articles = Content.list_articles()
    end
    render(conn, "index.html", articles: articles)
  end
end
