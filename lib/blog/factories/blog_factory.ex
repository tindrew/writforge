defmodule Blog.Factories.BlogFactory do
  alias Faker

  def post_factory do
    Faker.Lorem.paragraphs(2..5)
  end

  def comment_factory do
    Faker.Lorem.paragraph(1)
  end
end
