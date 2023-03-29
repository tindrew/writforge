defmodule Blog.Posts.Post do
  @moduledoc """
  Creates a schema and changeset for a Post.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published_on, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second)
    field :visible, :boolean
    has_many :comments, Blog.Comments.Comment
    many_to_many :tags, Blog.Tags.Tag, join_through: "post_tags", on_replace: :delete

    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @required [:content, :title, :published_on, :visible]
  @allowed [:user_id, :tags]
  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required ++ @allowed)
    |> put_assoc(:tags, tags)
    |> validate_required(@required)
  end
end
