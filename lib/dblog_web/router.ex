defmodule DblogWeb.Router do
  use DblogWeb, :router

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

  scope "/", DblogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DblogWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
  end

  # GraphQL setup
  # plug Plug.Parsers,
  #      parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
  #      pass: ["*/*"],
  #      json_decoder: Poison
  forward "/graphql",
          Absinthe.Plug,
          schema: DblogWeb.Schema

  forward "/graphiql",
          Absinthe.Plug.GraphiQL,
          schema: DblogWeb.Schema,
          interface: :simple
end
