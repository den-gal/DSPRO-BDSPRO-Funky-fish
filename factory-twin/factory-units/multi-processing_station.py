from unit import Unit

class MultyProcessingStation(Unit):
    """
    Multy-processing station unit that simulates the processing od the cargo
    """
    def __init__(self,
                 name: str = "Multy-processing station",
                 station: str = "mpo",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)