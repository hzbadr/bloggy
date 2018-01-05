defmodule Bloggy.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bloggy.Content.Article

  schema "articles" do
    field :content, :string
    field :title, :string
    field :view_count, :integer
    
    belongs_to :author, Bloggy.Coherence.User
    has_many :likes, Bloggy.ArticleUserLike

    timestamps()
  end

  @doc false
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, [:title, :content, :view_count])
    |> validate_required([:title, :content])
  end
end
