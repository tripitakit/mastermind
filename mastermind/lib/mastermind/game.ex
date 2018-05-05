defmodule Mastermind.Game do
  defstruct(
    type: nil,
    code: [],
    status: :initializing,
    guesses: [],
    turn: nil
  )

  alias Mastermind.{Code, Game}

  @turns 12

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

    score = %{
      blacks: count_pins(score, :black),
      whites: count_pins(score, :white)
    }

    guess = %{code: guessed, score: score}

    send_feedback(status, game.turn, guess, game)
  end

  defp send_feedback(:waiting_for_a_guess, turn, guess, game) when turn < @turns do
    %{game | status: :waiting_for_a_guess, guesses: game.guesses ++ [guess], turn: game.turn + 1}
  end

  defp send_feedback(:won, turn, guess, game) when turn <= @turns do
    %{game | status: :won, guesses: game.guesses ++ [guess]}
  end

  defp send_feedback(_status, _turn, _guess, game), do: %{game | status: :game_over}

  # code breaked!
  defp score_guess(guessed, code) when guessed == code do
    {:won, ~w(:black :black :black :black)}
  end

  # code not yet breaked
  defp score_guess(guessed, code) do
    score =
      for p <- 0..3 do
        guessed_peg = Enum.at(guessed, p)
        code_peg = Enum.at(code, p)
        score_peg(guessed_peg, code_peg, code)
      end

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
