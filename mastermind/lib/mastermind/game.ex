defmodule Mastermind.Game do
  defstruct(
    type: nil,
    code: [],
    status: :initializing,
    guesses: [],
    turn: nil
  )

  alias Mastermind.{Code, Game}

  @turns 3

  def new_game(opts \\ :simple) do
    %Game{
      type: opts,
      code: Code.new(opts),
      status: :waiting_for_a_guess,
      turn: 1
    }
  end

  def make_guess(guessed, game = %Game{}) do
    {status, score} = score_guess(guessed, game.code)

    guess = %{code: guessed, score: score}

    respond(game, status, game.turn, guess)
  end

  defp respond(game, _status, turn, _guess) when turn > @turns do
    %{game | status: :game_over}
  end

  defp respond(game, :you_won!, _turn, guess) do
    %{
      game
      | status: :you_won!,
        guesses: game.guesses ++ [guess]
    }
  end

  defp respond(game, :waiting_for_a_guess, turn, guess) when turn < @turns do
    %{
      game
      | status: :waiting_for_a_guess,
        guesses: game.guesses ++ [guess],
        turn: game.turn + 1
    }
  end

  defp respond(game, :waiting_for_a_guess, @turns, guess) do
    %{
      game
      | status: :game_over,
        guesses: game.guesses ++ [guess]
    }
  end

  # code breaked!
  defp score_guess(guessed, code) when guessed == code do
    {:you_won!, %{blacks: 4, whites: 0}}
  end

  # code not yet breaked
  defp score_guess(guessed, code) do
    scored =
      for p <- 0..3 do
        guessed_peg = Enum.at(guessed, p)
        code_peg = Enum.at(code, p)
        score_peg(guessed_peg, code_peg, code)
      end

    score = %{
      blacks: count_pins(scored, :black),
      whites: count_pins(scored, :white)
    }

    {:waiting_for_a_guess, score}
  end

  # check for black pins (right color in right position)   
  defp score_peg(guessed_peg, code_peg, _code) when guessed_peg == code_peg, do: :black

  # check for white pins (right color in wrong position) or empties
  defp score_peg(guessed_peg, _code_peg, code) do
    cond do
      guessed_peg in code -> :white
      true -> nil
    end
  end

  defp count_pins(score, color) do
    Enum.count(score, &(&1 == color))
  end
end
