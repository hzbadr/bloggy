defmodule BloggyWeb.FollowerController do
  use BloggyWeb, :controller

  alias Bloggy.Follower
  alias Bloggy.Repo

  def index(conn, _params) do
    followers = Repo.all(Follower)
    |> Repo.preload([:follower, :followee])
    render(conn, followers: followers)
  end

  def create(conn, params) do
    Follower.changeset(%Follower{}, params)
    |> Repo.insert!

    redirect(conn, to: article_path(conn, :index))
  end

  def delete(conn, %{"id" => user_id}) do
    current_user = Coherence.current_user(conn)
    Bloggy.Content.followers?(current_user.id, user_id)
    |> Repo.delete!
    redirect(conn, to: article_path(conn, :index))
  end

end
