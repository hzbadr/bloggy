defmodule Bloggy.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :content, :text
      add :view_count, :integer, default: 0
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
  end
end
