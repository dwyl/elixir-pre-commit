defmodule Mix.Tasks.CommitMsg do
  use Mix.Task

  @moduledoc """
    This file contains the functions that will be run when `mix commit_msg` is
    run. (we run it in the script in the `commit-msg` file in your `.git/hooks` directory)

    In here we just run all of the mix commands that you have put in your config file, and if they're succesful, print a success message to the
    the terminal, and if they fail we halt the process with a `1` error code (
    meaning that the command has failed), which will trigger the commit to stop,
    and print the error message to the terminal.
  """
  @commands Application.compile_env(:commit_msg, :commands) || []
  @verbose Application.compile_env(:commit_msg, :verbose) || false

  def run(_) do
    IO.puts("\e[95mCommit-msg running...\e[0m")
    {_, 0} = System.cmd("git", String.split("stash push --keep-index --message commit_msg", " "))

    @commands
    |> Enum.each(&run_cmds/1)

    System.cmd("git", String.split("stash pop", " "), stderr_to_stdout: true)
    |> case do
      {_, 0} ->
        "\e[32mCommit-msg passed!\e[0m"

      {"No stash entries found.", 1} ->
        "\e[32mCommit-msg passed!\e[0m"

      {error, _} ->
        error
    end
    |> IO.puts()

    System.halt(0)
  end

  defp run_cmds(cmd) do
    into =
      case @verbose do
        true -> IO.stream(:stdio, :line)
        _ -> ""
      end

    System.cmd("mix", String.split(cmd, " "), stderr_to_stdout: true, into: into)
    |> case do
      {_result, 0} ->
        IO.puts("mix #{cmd} ran successfully.")

      {result, _} ->
        if !@verbose, do: IO.puts(result)

        IO.puts(
          "\e[31mCommit-msg failed on `mix #{cmd}`.\e[0m \nCommit again with --no-verify to live dangerously and skip commit-msg."
        )

        {_, 0} = System.cmd("git", String.split("stash pop", " "))
        System.halt(1)
    end
  end
end
