defmodule ObanSample.Business do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id} = args}) do
    IO.inspect(args)
    model = ObanSample.Repo.get(ObanSample.Business.Man, id)
      |> IO.inspect(label: :a)

    IO.inspect(args, label: :perform)
    case args do
      %{"in_the" => "business"} ->
        IO.inspect(model)

      %{"vote_for" => vote} ->
        IO.inspect([vote, model])

      _ ->
        IO.inspect(model)
    end

    :ok
  end
end
