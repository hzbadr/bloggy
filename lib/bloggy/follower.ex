defmodule Bloggy.Follower do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bloggy.Follower


  schema "followers" do
    #field :follower_id, :id
    #field :followee_id, :id

    belongs_to :follower, Bloggy.Coherence.User
    belongs_to :followee, Bloggy.Coherence.User
    timestamps()
  end

  @doc false
  def changeset(%Follower{} = follower, attrs) do
    follower
    |> cast(attrs, [:follower_id, :followee_id])
    |> validate_required([:follower_id, :followee_id])
  end
end
