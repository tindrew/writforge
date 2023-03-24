defmodule Blog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :comment, :string
    belongs_to :post, Blog.Posts.Post

    @required [:comment, :post_id]

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
