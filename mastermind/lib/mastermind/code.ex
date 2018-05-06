defmodule Mastermind.Code do
  @colors [:red, :green, :blue, :yellow, :magenta, :cyan]

  def new(opts) do
    create_code(opts)
  end

  defp create_code(:simple) do
    @colors
    |> Enum.shuffle()
    |> Enum.take_random(4)
  end

  defp create_code(:allow_repeats) do
    for _i <- 1..4 do
      @colors
      |> Enum.shuffle()
      |> Enum.random()
    end
  end
end
