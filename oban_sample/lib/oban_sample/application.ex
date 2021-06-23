defmodule ObanSample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ObanSample.Repo,
      # Start the Telemetry supervisor
      ObanSampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ObanSample.PubSub},
      # Start the Endpoint (http/https)
      ObanSampleWeb.Endpoint,
      # Start a worker by calling: ObanSample.Worker.start_link(arg)
      # {ObanSample.Worker, arg}
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanSample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ObanSampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable queues or plugins here.
  defp oban_config do
    Application.fetch_env!(:oban_sample, Oban)
  end
end
