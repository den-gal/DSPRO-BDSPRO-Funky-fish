from broadcast import Broadcast
from camera import Camera
from high_bay_warehouse import HighBayWarehouse
from input_station import InputStation
from multiprocessing_station import MultiprocessingStation
from output_station import OutputStation
from sorting_line import SortingLine
from topic_parsers import TopicParser
from unit import Unit
from vacuum_suction_robot import VacuumStationRobot
from typing import Dict


class Factory(Unit):
    """
    Factory Unit that reflects the state of the Fisher Factory itself
    """
    def __init__(self,
                 name:str = "Factory",
                 station: str = "fct",
                 code: int = 1,
                 target: str = "",
                 description: str = "",
                 active: bool = False) -> None:
        super().__init__(name, station, code, target, description, active)

        self.hardware_model = ""
        self.software_name = ""
        self.software_version = ""
        self.hardware_id = 0
        self.message = ""
        self.units = {
            "camera": Camera(),
            "factory": self,
            "high_bay_warehouse": HighBayWarehouse(),
            "input_station": InputStation(),
            "multy_processing_station": MultiprocessingStation(),
            "output_station": OutputStation(),
            "sorting_line": SortingLine(),
            "vacuum_suction_robot": VacuumStationRobot()
        }
        self.topics = {
            # Todo: W1 connection point
            "topic_name": TopicParser("topic_name")
        }
        self.broadcast = Broadcast(self.units, self.topics)

    def receive_signal(self, signal: Dict[str, str|float|int]) -> None:
        self.hardware_model = str(signal["hardwareModel"])
        self.software_name = str(signal["softwareName"])
        self.software_version = str(signal["softwareVersion"])
        self.hardware_id = int(signal["hardwareId"])
        self.message = str(signal["message"])
        self.make_active(actual_active_timestamp=float(signal["ts"]))
