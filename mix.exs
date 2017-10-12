defmodule PreCommit.Mixfile do
  use Mix.Project

  def project do
    [app: :pre_commit,
     version: "0.1.3",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package()
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.13", only: :dev}
    ]
  end

  defp description do
    "A module which sets up a configurable pre-commit hook using elixir."
  end

  defp package do
    [
      name: "pre_commit",
      files: ["lib/", "priv/", "LICENSE", "mix.exs", "README.md"],
      links: %{"Github" => "https://www.github.com/dwyl/elixir-pre-commit"},
      licenses: ["GNU GPL v2.0"],
      maintainers: ["Zooey Miller", "Finn Hodgkin"]
    ]

  end
end
