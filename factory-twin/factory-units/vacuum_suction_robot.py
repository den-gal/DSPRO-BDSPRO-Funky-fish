from unit import Unit

class VacuumStationRobot(Unit):
    """
    Vacuum station robot unit that grabs the cargo and transports it between the stations
    """
    def __init__(self,
                 name: str = "Vacuum station robot",
                 station: str = "vgr",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)