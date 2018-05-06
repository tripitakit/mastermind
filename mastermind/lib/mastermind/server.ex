defmodule Mastermind.Server do
  use GenServer
  alias Mastermind.Game

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_args) do
    {:ok, Game.new_game()}
  end

  def handle_call({:guess, guess}, _from, game) do
    game = Game.guess(guess, game)
    tally = Game.tally(game)
    {:reply, tally, game}
  end

  def handle_call({:solution}, _from, game) do
    solution = Game.solution(game)
    {:reply, solution, game}
  end
end
