defmodule Mastermind.Game.ScoreHelper do
  # code breaked!
  def score_guess(guessed, code) when guessed == code do
    {:you_won!, %{blacks: 4, whites: 0}}
  end

  # code not yet breaked
  def score_guess(guessed, code) do
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

  ##############################################################################################

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
