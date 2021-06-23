defmodule ObanSample.Cron do
  use Oban.Worker

  @impl Oban.Worker
  def perform(job) do
    IO.inspect("minute worker")
    :ok
  end
end
