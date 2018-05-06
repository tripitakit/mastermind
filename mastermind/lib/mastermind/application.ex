defmodule Mastermind.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {Mastermind.Server, []}
    ]

    opts = [
      strategy: :simple_one_for_one,
      name: Mastermind.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
