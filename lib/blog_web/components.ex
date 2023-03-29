defmodule BlogWeb.Components do
  use Phoenix.Component

  def link(assigns) do
    ~H"""
      <a href={@href} class="sm:px-6 text-gray-600 duration-300  hover:border-b-4 border-white-400"><%= render_slot(@inner_block) %></a>
    """
  end
end
