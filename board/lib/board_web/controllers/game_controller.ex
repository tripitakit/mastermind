defmodule BoardWeb.GameController do
  use BoardWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def play(conn, _params) do
    game = Mastermind.new_game()
    # solution = Mastermind.solution?(game)

    conn
    |> put_session(:game, game)
    |> render(
      "game.html",
      tally: %{
        turn: 1,
        guesses: [],
        status: :waiting_for_a_guess
      }
    )
  end

  def guess(conn, params) do
    guess =
      params["code"]["guess"]
      |> String.split(",")
      |> Enum.map(&String.to_atom/1)

    game =
      conn
      |> get_session(:game)

    tally = Mastermind.guess!(game, guess)

    render(
      conn,
      "game.html",
      tally: tally
    )
  end
end
