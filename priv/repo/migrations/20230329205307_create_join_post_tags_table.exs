defmodule Blog.Repo.Migrations.CreateJoinPostTagsTable do
  use Ecto.Migration

  def change do
    create table(:post_tags) do
      add(:post_id, references(:posts, on_delete: :delete_all), null: false)
      add(:tag_id, references(:tags, on_delete: :delete_all), null: false)
    end

    create(unique_index(:post_tags, [:post_id, :tag_id]))
  end
end
