from unit import Unit


class OutputStation(Unit):
    """
    Output station unit stores requested cargo
    """
    def __init__(self,
                 name: str = "Output station",
                 station: str = "dso",
                 code: int = 1,
                 target: str = "",
                 description: str = "",
                 active: bool = False) -> None:
        super().__init__(name, station, code, target, description, active)