defmodule PreCommit do
  @moduledoc """
  This is a module for setting up pre-commit hooks on elixir projects. It's
  inspired by [pre-commit](https://www.npmjs.com/package/pre-commit) on npm
  and [pre_commit_hook](https://hex.pm/packages/pre_commit_hook) for Elixir.

  ### THIS MODULE WILL OVERWRITE YOUR CURRENT PRE-COMMIT HOOKS

  We wanted something which was configurable with your own mix commands and
  just in elixir, so we created our own module.

  The first step will be to add this module to your mix.exs.
  ```elixir
  def deps do
    [{:pre_commit, "~> 0.2.4", only: :dev}]
  end
  ```
  Then run mix deps.get. When the module is installed it will either create or overwrite your current `pre-commit` file in your `.git/hooks` directory.

  In your config file you will have to add in this line:
  ```elixir
    config :pre_commit, commands: ["test"]
  ```
  You can add any mix commands to the list, and these will run on commit,
  stopping the commit if they fail, or allowing the commit if they all pass.

  You can also have pre-commit display the output of the commands you run by
  setting the :verbose option.
  ```
  config :pre_commit,
  commands: ["test"],
  verbose: true
  ```

  You will have to compile your app before committing in order for the pre-commit to work.

  As a note, this module will only work with scripts which exit with a code of
  `1` on error, and a code of `0` on success. Some commands always exit with a
  `0` (success), so just make sure the command uses the right format before
  putting it in your pre-commit.

  We like adding [credo](https://github.com/rrrene/credo) and
  [coveralls](https://github.com/parroty/excoveralls) as well as `test`, to
  keep our code consistent and well covered!
  """
  copy = Mix.Project.deps_path() |> Path.join("pre_commit/priv/pre-commit")
  to = Mix.Project.deps_path() |> Path.join("../.git/hooks/pre-commit")

  unless File.exists?(Path.dirname(to)), do: File.mkdir_p!(Path.dirname(to))

  copy
  |> File.copy(to)

  to
  |> File.chmod(0o755)
end
