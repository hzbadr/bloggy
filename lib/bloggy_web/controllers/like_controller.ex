defmodule BloggyWeb.LikeController do
  use BloggyWeb, :controller

  alias Bloggy.ArticleUserLike
  alias Bloggy.Repo

  def create(conn, params) do
    ArticleUserLike.changeset(%ArticleUserLike{}, params)
    |> Repo.insert!
    
    redirect(conn, to: article_path(conn, :index))
  end
  
  def delete(conn, %{"id" => article_id}) do
    current_user = Coherence.current_user(conn)
    with like = Repo.get_by!(ArticleUserLike, user_id: current_user.id, article_id: article_id),
      Repo.delete!(like) do
      redirect(conn, to: article_path(conn, :index))
    end
  end
end