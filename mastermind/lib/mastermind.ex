defmodule Mastermind do
  @moduledoc """
  A game server to play Mastermind.

  The game server generates a secret four-colors code, out of six different colors, with no repetitions.
  The player has twelve turns to guess the correct code.

  Each guess is scored with one black peg for each correct color in theh.M correct code's position,
  and a white peg for each correct color in the wrong position.

  Game is over after twelve wrong guesses.
  """

  @type color :: atom()

  @doc """
  Creates a new game server and returns its PID.
  """
  @spec new_game() :: pid()
  def new_game() do
    {:ok, pid} = Supervisor.start_child(Mastermind.Supervisor, [])
    pid
  end

  @doc """
  Guesses a code in a game, and returns the updated game's tally,
  which include the current turn and status and the list of guesses,
  each composed by the guessed code and its score, expressed as
  black and white pegs counters, i.e.:

  ~~~~
  %{
    guesses: [
      %{
        code: [:red, :green, :yellow, :blue],
        score: %{blacks: 1, whites: 2}
      }
    ],
    status: :waiting_for_a_guess,
    turn: 2
  }
  ~~~


  The possible status values are:

  * :waiting_for_a_guess 
  * :game_over
  * :you_won!
  * :wrong_input

  """
  @spec guess!(game_pid :: pid(), guess :: [:color]) :: map()
  def guess!(game_pid, guess) do
    GenServer.call(game_pid, {:guess, guess})
  end

  @doc """
  Returns the game's solution as a list of color atoms, i.e.:

  ~~~~
  [:red, :green, :yellow, :blue]
  ~~~
  """
  @spec solution(game_pid :: pid()) :: [:color]
  def solution(game_pid) do
    GenServer.call(game_pid, {:solution})
  end
end
