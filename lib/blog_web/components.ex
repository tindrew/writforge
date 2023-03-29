defmodule BlogWeb.Components do
  use Phoenix.Component

  def link(assigns) do
    ~H"""
      <a href={@href} class="sm:px-8 rounded m-2 px-4 py-2 bg-gray-300 hover:bg-gray-500 transition-all duration-300"><%= render_slot(@inner_block) %></a>
    """
  end
end
