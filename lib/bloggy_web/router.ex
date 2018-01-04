defmodule BloggyWeb.Router do
  use BloggyWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Coherence.Authentication.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes
    coherence_routes :protected
  end

  scope "/", BloggyWeb do
    pipe_through :browser # Use the default browser stack
    
    get "/", PageController, :index

    resources "/articles", ArticleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BloggyWeb do
  #   pipe_through :api
  # end
end
