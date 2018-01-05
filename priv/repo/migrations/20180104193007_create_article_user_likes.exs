defmodule Bloggy.Repo.Migrations.CreateArticleUserLikes do
  use Ecto.Migration

  def change do
    create table(:article_user_likes) do
      add :article_id, references(:articles, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:article_user_likes, [:article_id])
    create index(:article_user_likes, [:user_id])
  end
end
