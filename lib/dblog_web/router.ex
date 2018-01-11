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

  pipeline :graphql do
    plug DblogWeb.Plug.Graphql.Context
  end

  # This plug will look for a Guardian token in the session in the default
  # location. Then it will attempt to load the resource found in the JWT.
  # If it doesn't find a JWT in the default location it doesn't do anything
  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
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

  scope "/graphql" do
    pipe_through [:api, :graphql, :api_auth]

    # plug Plug.Parsers,
    #      parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    #      pass: ["*/*"],
    #      json_decoder: Poison

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: DblogWeb.Schema

    forward "/",
            Absinthe.Plug,
            schema: DblogWeb.Schema
  end
end
