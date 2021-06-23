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

  def attempt_1(conn, _) do
    %{id: 2}
    |> ObanSample.Business.new(schedule_in: 5*60, max_attempts: 1)
    |> Oban.insert()

    json(conn, %{msg: "worked"})
  end
end
