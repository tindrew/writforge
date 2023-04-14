defmodule BlogWeb.PostView do
  use BlogWeb, :view

  def obfuscate(string) do
    #   # alias Regex

    # Regex.replace(~r/(fuck|shit|puppy)/ix, string, "<span class=\"blur\">\\1</span>")

    Regex.replace(~r[fuck* | shit | damb | pupp+]ix, string, fn captured ->
      "<span class=\"blur\">#{captured}</span>"
    end)
  end
end
