defmodule ObanSample.Business do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => _id} = args}) do
    IO.inspect(args, label: :args)

    case args do
      %{"in_the" => "business"} ->
        IO.inspect("business")

      %{"vote_for" => _vote} ->
        IO.inspect("vote-for")

      %{"id" => obtained_id} ->
        IO.inspect("obtained_id: #{obtained_id}")
    end

    :ok
  end
end
