import time

class Unit:
    """
    Template class for units of the factory.
    """

    def __init__(self, name:str, station:str, code:int, target = None, description = None, active:bool=False):
        """
        Args:
            name: human-like name of the unit
            station: the name of the station (hbw/vgr/mpo/sld/dsi/dso/fct/ptu)
            code: status or error code
            description: description of the station (nullable, usually empty)
            target: nullable, only set for vgr code=2
            active: boolean status of the station
        """
        self.name = name
        self.station = station
        self.code = code
        self.active = active
        self.description = description
        self.active_timestamp = None
        self.actual_active_timestamp = None
        self.inactive_timestamp = None
        self.actual_inactive_timestamp = None
        self.target = target

    def make_active(self, actual_active_timestamp:float):
        self.active = True
        self.actual_active_timestamp = actual_active_timestamp
        self.active_timestamp = time.time()

    def make_inactive(self, actual_inactive_timestamp:float):
        self.active = False
        self.actual_inactive_timestamp = actual_inactive_timestamp
        self.inactive_timestamp = time.time()


    def method_is_not_implemented(self, method_name:str):
        raise NotImplementedError(f"This {self.station} unit must implement {method_name} method ")

    def receive_signal(self, signal:dict):
        self.method_is_not_implemented("receive_signal")

    def send_signal(self, signal:dict):
        self.method_is_not_implemented("send_signal")

    def handle_an_error(self, error_type, error_message):
        self.method_is_not_implemented("handle_an_error")
