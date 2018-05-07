defmodule BoardWeb.Router do
  use BoardWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BoardWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", GameController, :new_game)

    put("/guess", GameController, :guess)
  end

  # Other scopes may use custom stacks.
  # scope "/api", BoardWeb do
  #   pipe_through :api
  # end
end
