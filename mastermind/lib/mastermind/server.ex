defmodule Mastermind.Server do
  use GenServer
  alias Mastermind.Game

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_args) do
    {:ok, Game.new_game()}
  end

  def handle_call({:make_guess, guess}, _from, game) do
    game = Game.make_guess(guess, game)
    {:reply, game, game}
  end
end
