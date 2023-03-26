defmodule Blog.Comments.Comment do
  @moduledoc """
  Creates a schema and changeset for a Comment.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required [:content, :post_id]

  schema "comments" do
    field :content, :string
    belongs_to :post, Blog.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
