defmodule CortoWeb.LinkController do
  use CortoWeb, :controller

  alias Corto.Links
  alias Corto.Link

  def index(conn, _params) do
    links = Links.list_links()
    render(conn, "index.json", links: links)
  end

  def create(conn, %{"link" => link_params}) do
    with {:ok, %Link{} = link} <- Links.create_link(link_params) do
      conn
      |> put_status(:created)
      ##|> put_resp_header("location", link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    with {:ok, %Link{}} <- Links.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_and_redirect(conn, %{"id" => id}) do
    try do
      url = id
            |> Links.get_link!()
            |> Map.get(:url)
      redirect(conn, external: url)
    rescue
       _->
         redirect(conn, to: "/")
    end


    #IO.puts("----------------")
    #IO.inspect(url)
    #IO.puts("----------------")

    #redirect(conn, external: url)
  end
end
