defmodule Mix.Tasks.PreCommit do
  use Mix.Task

  @commands Application.get_env(:elixir_pre_commit, :commands) || []

  def run(_) do
    @commands
    |> Enum.map(&run_cmds/1)

    IO.puts "\e[32mPre-commit passed!\e[0m"
    System.halt(0)
  end

  defp run_cmds(cmd) do
    System.cmd("mix", [cmd], stderr_to_stdout: true)
    |> case do
      {_result, 0} ->
        IO.puts "mix #{cmd} ran successfully."
      {result, _} ->
        IO.puts result
        IO.puts "\e[31mPre-commit failed on `mix #{cmd}`.\e[0m \nCommit again with --no-verify to live dangerously and skip pre-commit."
        System.halt(1)
    end
  end
end
