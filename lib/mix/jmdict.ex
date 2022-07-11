defmodule Mix.Tasks.Jmdict do
  use Mix.Task

  @requirements ["app.start"]

  def run(_) do
    J.save()
  end
end
