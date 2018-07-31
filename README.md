# PreCommit

### THIS MODULE WILL OVERWRITE YOUR CURRENT PRE-COMMIT HOOKS

This is a module for setting up pre-commit hooks on elixir projects. It's
inspired by [pre-commit](https://www.npmjs.com/package/pre-commit) on npm and
[pre_commit_hook](https://hex.pm/packages/pre_commit_hook) for Elixir.

We wanted something which was configurable with your own mix commands and just
in Elixir, so we created our own module. This module will only work with git
versions 2.13 and above.

The first step will be to add this module to your mix.exs.

```elixir
def deps do
  [{:pre_commit, "~> 0.3.4", only: :dev}]
end
```

Then run mix deps.get. When the module is installed it will either create or
overwrite your current `pre-commit` file in your `.git/hooks` directory.

In your config file you will have to add in this line:

```elixir
  config :pre_commit, commands: ["test"]
```

You can add any mix commands to the list, and these will run on commit, stopping
the commit if they fail, or allowing the commit if they all pass.

You can also have pre-commit display the output of the commands you run by
setting the :verbose option.

```
  config :pre_commit,
    commands: ["test"],
    verbose: true
```

You will have to compile your app before committing in order for the pre-commit
to work.

As a note, this module will only work with scripts which exit with a code of `1`
on error, and a code of `0` on success. Some commands always exit with a `0`
(success), so just make sure the command uses the right format before putting it
in your pre-commit.

We like adding [credo](https://github.com/rrrene/credo) and
[coveralls](https://github.com/parroty/excoveralls) as well as `test`, to keep
our code consistent and well covered!

There is a [known issue](https://github.com/dwyl/elixir-pre-commit/issues/32)
with the fact that running the pre-commit will restore deleted files to the working
tree.
