defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  use Ecto.Schema

  alias Blog.Comments
  alias Blog.Comments.Comment
  #alias Floki.HTMLTree.Comment
  alias Blog.Posts
  alias Blog.Posts.Post

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
    # comment_changeset = Comments.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  #comment_changeset: comment_changeset

  def create(conn, %{"post" => post_params}) do
    case Posts.create_post(post_params) do
      {:ok, post} ->
        IO.inspect(conn, label: "*********** WTF? Over! ***************")
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset, label: "Come On Fucker")
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_comment(conn, %{"comment" => comment_params}) do
    IO.inspect(conn, label: "DAFAQ")
    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
      conn
      |> IO.inspect(label: "Hard Knocks!")
      |> put_flash(:info, "comment created argumentatively")
      |> redirect(to: Routes.post_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def show(conn, %{"id" => id}) do
    changeset = Comments.change_comment(%Comment{})


    post = Posts.get_post!(id)
    comments = Comments.list_comments()
    render(conn, "show.html", post: post, comments: comments, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    changeset = Posts.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end




end
