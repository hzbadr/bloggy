defmodule BloggyWeb.ArticleController do
  use BloggyWeb, :controller

  alias Bloggy.Content
  alias Bloggy.Content.Article

  def index(conn, params) do
    articles = with %{"author_id" => author_id} <- params do
      Content.list_articles(%{author_id: author_id})
    else
      err ->  Content.list_articles()
    end
    render(conn, "index.html", articles: articles)
  end

  def new(conn, _params) do
    changeset = Content.change_article(%Article{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do
    current_user = Coherence.current_user(conn)
    article_params = Map.put(article_params, :author_id, current_user.id)

    case Content.create_article(article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Content.get_article!(id)
    {:ok, article} = Content.increment_view_count(article)
    render(conn, "show.html", article: article)
  end

  def edit(conn, %{"id" => id}) do
    article = Content.get_article!(id)
    changeset = Content.change_article(article)
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Content.get_article!(id)

    case Content.update_article(article, article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Content.get_article!(id)
    {:ok, _article} = Content.delete_article(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: article_path(conn, :index))
  end
end
