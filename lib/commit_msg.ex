defmodule CommitMsg do
  @moduledoc """
  This is a module for setting up commit-msg hooks on elixir projects. It's
  a fork of [elixir-pre-commit](https://www.npmjs.com/package/pre-commit) on Github

  ### THIS MODULE WILL OVERWRITE YOUR CURRENT COMMIT-MSG HOOKS

  We wanted something which was configurable with your own mix commands and
  just in elixir, so we created our own module. This module will only work
  with git versions 2.13 and above.

  The first step will be to add this module to your mix.exs.
  ```elixir
  def deps do
    [{:commit_msg, "~> 0.1.0", only: :dev}]
  end
  ```
  Then run mix deps.get. When the module is installed it will either create or overwrite your current `pre-commit` file in your `.git/hooks` directory.

  In your config file you will have to add in this line:
  ```elixir
    config :commit_msg, commands: ["test"]
  ```
  You can add any mix commands to the list, and these will run on commit,
  stopping the commit if they fail, or allowing the commit if they all pass.

  You can also have commit-msg display the output of the commands you run by
  setting the :verbose option.
  ```
  config :commit_msg,
    commands: ["test"],
    verbose: true
  ```

  You will have to compile your app before committing in order for the commit-msg to work.

  As a note, this module will only work with scripts which exit with a code of
  `1` on error, and a code of `0` on success. Some commands always exit with a
  `0` (success), so just make sure the command uses the right format before
  putting it in your commit-msg.
  """
  copy = Mix.Project.deps_path() |> Path.join("commit_msg/priv/commit-msg")
  to = Mix.Project.deps_path() |> Path.join("../.git/hooks/commit-msg")

  unless File.exists?(Path.dirname(to)), do: File.mkdir_p!(Path.dirname(to))

  copy
  |> File.copy(to)

  to
  |> File.chmod(0o755)
end
