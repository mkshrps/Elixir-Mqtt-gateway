defmodule MqttGateway.Mqtt do
@moduledoc """
MQTT api for communication via totoise311 connection
"""
  def send_mqtt(opts, payload) do
    report_topic = "reports/#{opts[:clientid]}/telemetry"
    Tortoise311.publish("mqtt_gateway", report_topic,payload, qos: 0)
  end

  def update_payload(payload) do
    send_mqtt([clientid: "mqtt_gateway"], payload)
  end
end
