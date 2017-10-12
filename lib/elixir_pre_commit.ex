defmodule ElixirPreCommit do
  @moduledoc """
  This module copies our pre-commit setup to `/.git/hooks/`.

  To choose which of your mix tasks to run as a pre-commit add the following
  to your config:
  
  `config :elixir_pre_commit, commands: ["test", "coveralls", "credo"]`
  """
  copy = Mix.Project.deps_path() |> Path.join("../priv/pre-commit")
  to = Mix.Project.deps_path() |> Path.join("../.git/hooks/pre-commit")

  File.copy(copy, to)
  File.chmod(to, 0o755)
end
