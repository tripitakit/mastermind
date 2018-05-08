defmodule Mastermind.Game.StateUpdater do
  @turns 12

  def update_state!(game, status, turn, guess \\ nil) do
    update_state(game, status, turn, guess)
  end

  defp update_state(game, _status, turn, _guess) when turn > @turns do
    %{game | status: :game_over}
  end

  defp update_state(game, :you_won!, _turn, guess) do
    %{
      game
      | status: :you_won!,
        guesses: game.guesses ++ [guess]
    }
  end

  defp update_state(game, :waiting_for_a_guess, turn, guess) when turn < @turns do
    %{
      game
      | status: :waiting_for_a_guess,
        guesses: game.guesses ++ [guess],
        turn: game.turn + 1
    }
  end

  defp update_state(game, :waiting_for_a_guess, @turns, guess) do
    %{
      game
      | status: :game_over,
        guesses: game.guesses ++ [guess]
    }
  end

  defp update_state(game, :wrong_input, _turn, _guess) do
    %{game | status: :wrong_input}
  end
end
