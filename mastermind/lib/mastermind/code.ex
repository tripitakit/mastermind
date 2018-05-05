defmodule Mastermind.Code do
  @colors [:red, :green, :blue, :yellow, :magenta, :cyan]

  def new(opts) do
    create_code(opts)
  end

  defp create_code(:simple) do
    Enum.take_random(@colors, 4)
  end

  defp create_code(:allow_repeats) do
    for _i <- 1..4, do: Enum.random(@colors)
  end
end
