from unit import Unit


class SortingLine(Unit):
    """
    Sorting line unit that sorts the cargo by the color
    """
    def __init__(self,
                 name: str = "Sorting line",
                 station: str = "sld",
                 code: int = 1,
                 target: str = "",
                 description: str = "",
                 active: bool = False) -> None:
        super().__init__(name, station, code, target, description, active)