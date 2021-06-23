defmodule ObanSampleWeb.PageController do
  use ObanSampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def normal(conn, _) do
    %{id: 1}
    |> ObanSample.Business.new(schedule_in: 2, max_attempts: 2)
    |> IO.inspect(label: :in_normal)
    |> Oban.insert()

    json(conn, %{msg: "worked"})
  end

  def attempt1(conn, _) do
    id = %{id: 2}
      |> ObanSample.Business.new(schedule_in: 2*60, max_attempts: 1)
      |> Oban.insert()
      |> elem(1)
      |> Map.get(:id)

    json(conn, %{msg: "worked", id: id})
  end

  def attempt2(conn, _) do
    id = %{id: 3}
      |> ObanSample.Business.new()
      |> Oban.insert()
      |> elem(1)
      |> Map.get(:id)

    json(conn, %{msg: "worked", id: id})
  end

  def attempt3(conn, _) do
    id = %{id: 4, message: "attempt 3"}
      |> ObanSample.Business.new(schedule_in: 2*60)
      |> Oban.insert()
      |> elem(1)
      |> Map.get(:id)

    json(conn, %{msg: "worked", id: id})
  end

  def cancel1(conn, %{"id" => id}) do
    id
    |> String.to_integer()
    |> Oban.cancel_job()
    |> IO.inspect()

    json(conn, %{msg: "worked"})
  end
end
