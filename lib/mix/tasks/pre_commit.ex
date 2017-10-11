defmodule Mix.Tasks.PreCommit do
  use Mix.Task

  def run(_) do
    Application.get_env(:elixir_pre_commit, :commands)
    |> Enum.map(&run_cmds/1)
    |> IO.inspect
  end

  defp run_cmds(cmd) do
    {result, code} =
      System.cmd("mix", [cmd], stderr_to_stdout: true)

    case code do
      0 ->
        IO.puts "#{cmd} ran successfully."
      _ ->
        IO.puts result
        System.halt(1)
    end
  end
end
