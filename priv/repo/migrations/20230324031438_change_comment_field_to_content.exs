defmodule Blog.Repo.Migrations.ChangeCommentFieldToContent do
  use Ecto.Migration

  def change do
    alter table("comments") do
      remove :comment
      add :content, :text
    end
  end
end
