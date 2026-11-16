from unit import Unit


class MultiprocessingStation(Unit):
    """
    Multy-processing station unit that simulates the processing od the cargo
    """
    def __init__(self,
                 name: str = "Multy-processing station",
                 station: str = "mpo",
                 code: int = 1,
                 target: str = "",
                 description: str = "",
                 active: bool = False) -> None:
        super().__init__(name, station, code, target, description, active)