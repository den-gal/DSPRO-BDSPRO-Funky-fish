from unit import Unit

class Factory(Unit):
    """
    Factory Unit that reflects the state of the Fisher Factory itself
    """
    def __init__(self,
                 name:str = "Factory",
                 station: str = "fct",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)

        self.hardware_model = ""
        self.software_name = ""
        self.software_version = ""
        self.hardware_id = 0
        self.message = ""

    def receive_signal(self, signal: dict):
        self.hardware_model = signal["hardwareModel"]
        self.software_name = signal["softwareName"]
        self.software_version = signal["softwareVersion"]
        self.hardware_id = signal["hardwareId"]
        self.message = signal["message"]
        self.make_active(actual_active_timestamp=signal["ts"])
