defmodule Bloggy.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Bloggy.Repo

  alias Bloggy.Content.Article
  alias Bloggy.ArticleUserLike
  alias Bloggy.Follower

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles(%{author_id: author_id}) do
    query = from article in Article, where: article.author_id == ^author_id
    Repo.all(query)
  end

  def list_articles() do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{source: %Article{}}

  """
  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end

  @doc """
  
  """
  def increment_view_count(%Article{} = article) do
    article
    |> Article.changeset(%{view_count: article.view_count+1})
    |> Repo.update
  end

  def list_articles_with_likes(user_id) do
    query = from article in "articles",
            left_join: like in ArticleUserLike, on: [article_id: article.id], 
            select: %{id: article.id, title: article.title, 
                      content: article.content, author_id: article.author_id, 
                      view_count: article.view_count, likes: count(like.id)},
            group_by: [article.id],
            order_by: [article.id]

    IO.inspect Repo.all query
  end

  def user_liked_article?(user_id, article_id) do
    ArticleUserLike
    |> Repo.get_by(%{user_id: user_id, article_id: article_id})
  end
  
  def article_likes_count(article_id) do
    query = from like in ArticleUserLike, select: count(like.id), where: like.article_id == ^article_id
    Repo.get!(query)
  end

  def followers?(user_1, user_2) do
    query = from f in Follower, 
            select: %Follower{id: f.id},
            where: (f.follower_id == ^user_1 and f.followee_id == ^user_2) or 
                   (f.follower_id == ^user_2 and f.followee_id == ^user_1)
    IO.inspect Repo.one(query)
  end
end
