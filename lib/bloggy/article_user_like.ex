defmodule Bloggy.ArticleUserLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bloggy.ArticleUserLike


  schema "article_user_likes" do
    field :article_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%ArticleUserLike{} = article_user_like, attrs) do
    article_user_like
    |> cast(attrs, [:user_id, :article_id])
    |> validate_required([])
  end
end
