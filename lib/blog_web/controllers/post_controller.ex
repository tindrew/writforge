defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  use Ecto.Schema

  alias Blog.Comments
  alias Blog.Comments.Comment
  # alias Floki.HTMLTree.Comment
  alias Blog.Posts
  alias Blog.Posts.Post
  # alias Blog.Tags.Tag
  alias Blog.Tags

  plug :require_user_owns_post when action in [:edit, :update, :delete]

  def index(conn, %{"title" => title}) do
    posts = Posts.list_posts(title: title)
    render(conn, "index.html", posts: posts)
  end

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})

    tags = Tags.list_tags()

    render(conn, "new.html", changeset: changeset, tags: tags)
  end

  def create(conn, %{"post" => post_params}) do
    post_params = Map.put(post_params, "user_id", conn.assigns[:current_user].id)

    {tag_ids, post_params} = Map.pop(post_params, "tags", [])
    post_tags = Enum.map(tag_ids, &Tags.get_tag!/1)
    tags = Tags.list_tags()

    case Posts.create_post(post_params, post_tags) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, tags: tags)
    end
  end

  def create_comment(conn, %{"comment" => comment_params} = params) do
    comment = Map.put(comment_params, "post_id", params["post_id"])

    case Comments.create_comment(comment) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "comment created argumentatively")
        |> redirect(to: Routes.post_path(conn, :show, comment.post_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    changeset = Comments.change_comment(%Comment{})

    post = Posts.get_post!(id)

    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    tags = Tags.list_tags()

    post = Posts.get_post!(id)

    changeset = Posts.change_post(post)

    tag_ids =
      Enum.map(post.tags, fn tag ->
        tag.id
      end)

    render(conn, "edit.html", changeset: changeset, post: post, tags: tags, tag_ids: tag_ids)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    tags =
      Enum.map(post_params["tags"], fn tag_id ->
        Tags.get_tag!(tag_id)
      end)

    case Posts.update_post(post, post_params, tags) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset, tags: tags)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def require_user_owns_post(conn, _opts) do
    post_id = String.to_integer(conn.path_params["id"])
    post = Posts.get_post!(post_id)

    if conn.assigns[:current_user].id == post.user_id do
      conn
    else
      conn
      |> put_flash(:error, "You do not own this resource.")
      |> redirect(to: Routes.post_path(conn, :index))
      |> halt()
    end
  end
end
