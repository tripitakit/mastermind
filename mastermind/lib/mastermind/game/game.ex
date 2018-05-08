defmodule Mastermind.Game do
  defstruct(
    type: nil,
    code: [],
    status: :initializing,
    guesses: [],
    turn: nil
  )

  alias Mastermind.{Code, Game}
  alias Mastermind.Game.{ScoreHelper, StateUpdater}

  def new_game(opts \\ :simple) do
    %Game{
      type: opts,
      code: Code.new(opts),
      status: :waiting_for_a_guess,
      turn: 1
    }
  end

  def guess(guessed, game = %Game{}) do
    cond do
      is_list(guessed) and Enum.count(guessed) == 4 ->
        {status, score} = ScoreHelper.score_guess(guessed, game.code)
        guess = %{code: guessed, score: score}
        StateUpdater.update_state!(game, status, game.turn, guess)

      true ->
        StateUpdater.update_state!(game, :wrong_input, game.turn)
    end
  end

  def tally(game = %Game{}) do
    %{
      status: game.status,
      turn: game.turn,
      guesses: game.guesses
    }
  end

  def solution(game = %Game{}), do: game.code
end
