defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published_on, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second)
    field :visible, :boolean

    timestamps()
  end

  @required [:content, :title, :published_on, :visible]
  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
