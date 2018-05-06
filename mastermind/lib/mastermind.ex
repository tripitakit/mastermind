defmodule Mastermind do
  def new_game() do
    {:ok, pid} = Supervisor.start_child(Mastermind.Supervisor, [])
    pid
  end

  def guess!(game_pid, guess) do
    GenServer.call(game_pid, {:guess, guess})
  end

  def solution?(game_pid) do
    GenServer.call(game_pid, {:solution})
  end
end
