defmodule Blog.Repo.Migrations.UserHasManyPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :user_id, :integer
    end
  end
end
