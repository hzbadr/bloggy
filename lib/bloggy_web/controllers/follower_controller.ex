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
  
  def delete(conn, %{"id" => id}) do
    current_user = Coherence.current_user(conn)
    with followship = Repo.get!(Follower, id),
      Repo.delete!(followship) do
      redirect(conn, to: article_path(conn, :index))
    end
  end
  
end
