defmodule Blog.Repo.Migrations.AddPublishedOnAndVisibleFields do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :published_on, :utc_datetime_usec
      add :visible, :boolean
    end
  end
end
