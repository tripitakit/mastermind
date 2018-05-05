defmodule Mastermind do
  defdelegate new_game, to: Mastermind.Game
  defdelegate make_guess(guessed, game), to: Mastermind.Game
end
