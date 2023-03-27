defmodule Blog.Factories.BlogFactory do
  @moduledoc """
  Creates seed data to populate the dev database
  """
  alias Faker

  def post_w_comments(attrs \\ %{}) do
    num =
      IO.gets("Number of Comments ")
      |> String.trim()
      |> String.to_integer()

    Enum.reduce(1..num, [], fn _el, _acc ->
      {:ok, post} =
        attrs
        |> Enum.into(post_params_factory())
        |> Blog.Posts.create_post()

      generate_comments(%{post_id: post.id})
    end)
  end

  defp generate_comments(attrs) do
    number_of_comments = Enum.random(1..20)

    Enum.map(0..number_of_comments, fn _el ->
      attrs
      |> Enum.into(%{content: comment_params_factory()})
      |> Blog.Comments.create_comment()
    end)
  end

  defp post_params_factory do
    title =
      Faker.Lorem.words(1..5)
      |> Enum.reduce("", fn el, acc -> acc <> " " <> el end)
      |> String.trim()

    content =
      Faker.Lorem.paragraphs(1..5)
      |> Enum.reduce("", fn el, acc -> acc <> " " <> el end)
      |> String.trim()

    %{title: title, content: content, visible: true}
  end

  defp comment_params_factory() do
    Faker.Lorem.paragraph(1)
  end
end
