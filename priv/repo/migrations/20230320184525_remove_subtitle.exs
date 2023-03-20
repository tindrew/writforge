defmodule Blog.Repo.Migrations.RemoveSubtitle do
  use Ecto.Migration

  def change do
    alter table("posts") do
      remove :subtitle
    end
  end
end
