defmodule ObanSample.Business do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => _id} = args}) do
    IO.inspect(args, label: :args)
    #model = ObanSample.Repo.get(ObanSample.Business.Man, id)

    IO.inspect(args, label: :perform)
    case args do
      %{"in_the" => "business"} ->
        #IO.inspect(model)
        IO.inspect("business")

      %{"vote_for" => _vote} ->
        #IO.inspect([vote, model])
        IO.inspect("vote-for")

      %{"id" => obtained_id} ->
        IO.inspect(obtained_id, label: :obtained_id)
    end

    :ok
  end
end
