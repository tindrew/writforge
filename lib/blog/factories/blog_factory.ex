defmodule Blog.Factories.BlogFactory do
  alias Faker

  def post_factory do
    Faker.Lorem.paragraphs(2..5)
  end
end
