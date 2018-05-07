defmodule BoardWeb.GameController do
  use BoardWeb, :controller


  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def play(conn, _params) do
    game = Mastermind.new_game()
    solution = Mastermind.solution?(game)

    conn
    |> put_session(:game, game)
    |> render(
      "game.html",
      tally: %{
        turn: 1,
        guesses: [],
        status: :waiting_for_a_guess,
        solution: solution
      }
    )
  end
end
