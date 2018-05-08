defmodule BoardWeb.GameView do
  use BoardWeb, :view

  def guessed_color(guesses, turn, peg) do
    if guess = Enum.at(guesses, turn - 1) do
      Enum.at(guess[:code], peg)
      |> to_string()
    else
      nil
    end
  end

  def score_pins(guesses, turn, score_pos) do
    if guess = Enum.at(guesses, turn - 1) do
      %{blacks: blacks, whites: whites} = guess[:score]

      cond do
        blacks > score_pos -> :black
        blacks + whites > score_pos -> :white
        true -> :none
      end
    else
      :none
    end
  end

  def game_status(tally) do
    status =
      case tally.status do
        :waiting_for_a_guess -> "Waiting for a code ..."
        :you_won! -> "Well done code-breaker! You won!"
        :game_over -> "Game over. Retry with a new code!"
        :wrong_input -> "Incomplete code, please guess again ..."
      end

    "Turn #{tally.turn}. #{status}"
  end

  def highlight_current_turn(drawn_turn, current_turn) do
    if drawn_turn == current_turn do
      "white;"
    else
      "rgb(77, 77, 77);"
    end
  end
end
