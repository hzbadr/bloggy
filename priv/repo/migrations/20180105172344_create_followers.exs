defmodule Bloggy.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      add :follower_id, references(:users, on_delete: :nothing)
      add :followee_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:followers, [:follower_id])
    create index(:followers, [:followee_id])
  end
end
