import paho.mqtt.client as mqtt
from paho.mqtt.reasoncodes import ReasonCode
from paho.mqtt.properties import Properties

from paho.mqtt.enums import CallbackAPIVersion
from typing import Dict, Any

from paho.mqtt.reasoncodes import ReasonCode


class Broadcast:
    """
    Broadcast class connects to the MQTT broker, subscribes to the topics and sends messages
    """
    def __init__(self,
                 units: Dict[str, object],
                 topics: Dict[str, object]):
        self.units = units
        self.topics = topics
        self.mqtt_client= mqtt.Client(CallbackAPIVersion.VERSION2)
        self.mqtt_client.on_connect = self.on_connect
        self.mqtt_client.on_message = self.on_message

    @staticmethod
    def on_connect(client: mqtt.Client,
                   userdata: Any,
                   flags: Dict[str, Any],
                   reason_code: ReasonCode,
                   properties: Properties | None) -> None:
        # Todo: W1 connection point
        print(f"Connected with result code {reason_code}")
        # Subscribing in on_connect() means that if we lose the connection and
        # reconnect then subscriptions will be renewed.
        # client.subscribe("$SYS/#")

    def on_message(self,
                   client: mqtt.Client,
                   userdata: Any,
                   msg: mqtt.MQTTMessage) -> None:
        # print(msg.topic + " " + str(msg.payload))
        # Todo: W1 connection point
        # self.receive({"topic": str(msg.topic), "payload": str(msg.payload)})
        pass

    def receive(self, signal: Dict[str, str|float|int]) -> None:
        if signal["topic"] in self.topics:
            # Todo: W1 connection point
            pass
        else:
            raise KeyError(f"Topic name from signal {signal['topic']} is not in the list of topics: "
                           f"{list(self.topics.keys())}")

    def send(self, signal: Dict[str, str|float|int]) -> None:
        if signal["topic"] in self.topics:
            # Todo: W1 connection point
            pass
        else:
            raise KeyError(f"Topic name from signal {signal['topic']} is not in the list of topics: "
                           f"{list(self.topics.keys())}")
