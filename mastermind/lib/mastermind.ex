defmodule Mastermind do
  def new_game() do
    {:ok, pid} = Supervisor.start_child(Mastermind.Supervisor, [])
    pid
  end

  def make_guess(game_pid, guess) do
    GenServer.call(game_pid, {:make_guess, guess})
  end
end
