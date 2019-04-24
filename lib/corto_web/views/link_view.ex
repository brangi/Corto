defmodule CortoWeb.LinkView do
  use CortoWeb, :view
  alias CortoWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    {:ok, hostname} = :inet.gethostname
    host = case hostname do
       'corto' -> "http://corto.link/"
       _-> "http://localhost:4000/"
      end
    %{
      hash: link.hash,
      url: link.url,
      shortLink: "#{host}#{link.hash}"
    }
  end
end
