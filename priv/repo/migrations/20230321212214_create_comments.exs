defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :text
      add :post_id, references(:posts, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end
