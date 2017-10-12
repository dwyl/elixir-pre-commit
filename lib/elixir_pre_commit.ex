defmodule ElixirPreCommit do
  @moduledoc """
  config :elixir_pre_commit, commands: ["test", "coveralls", "credo"]
  """
  copy = Mix.Project.deps_path() |> Path.join("../priv/pre-commit")
  to = Mix.Project.deps_path() |> Path.join("../.git/hooks/pre-commit")

  File.copy(copy, to)
  File.chmod(to, 0o755)
end
