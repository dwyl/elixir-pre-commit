defmodule CommitMsg.Mixfile do
  use Mix.Project

  def project do
    [app: :commit_msg,
     version: "0.3.4",
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
      {:ex_doc, "~> 0.13", only: :dev},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "A module which sets up a configurable commit-msg hook using elixir."
  end

  defp package do
    [
      name: "pre_commit",
      files: ["lib/", "priv/", "LICENSE", "mix.exs", "README.md"],
      links: %{"Github" => "https://www.github.com/Odovren/elixir-commit-message"},
      licenses: ["GNU GPL v2.0"],
      maintainers: ["Odovren"]
    ]

  end
end
