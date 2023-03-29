defmodule MqttGateway.Connection do

  use Supervisor

  @moduledoc """
  This is the supervisor which starts the Toroise MQTT connection`.
  Start this from the parent Application supervision tree
  Opts requred
  clientid: unique mqtt identifier
  host: ::charlist()
  subscriptions: list of topics

  """

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end
# connect to the server and subscribe to foo/bar with QoS 0
  def init(opts) do

    report_topics = "reports/#{opts[:clientid]}/telemetry"

    children = [
    {Tortoise311.Connection,
      [
      client_id: opts[:clientid],
      handler: {Tortoise.Handler, []},
      server: {Tortoise311.Transport.Tcp, host: 'public.mqtthq.com', port: 1883},
      subscriptions: [{report_topics, 0}]
      ]

      }
    ]
    Supervisor.init(children, strategy: :one_for_one)

  end

end

     # handler: {Tortoise.Handler.Logger, []},
