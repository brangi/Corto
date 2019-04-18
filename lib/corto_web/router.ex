defmodule CortoWeb.Router do
  use CortoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CortoWeb do
    pipe_through :api
    resources "/links", LinkController, except: [:edit]
  end

  scope "/", CortoWeb do
    get "/:id", LinkController, :get_and_redirect
  end


end
