defmodule TestApp.Router do
  use TestApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestApp do
    pipe_through :browser # Use the default browser stack

    get "/", InnController, :check_inn
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestApp do
  #   pipe_through :api
  # end
end
