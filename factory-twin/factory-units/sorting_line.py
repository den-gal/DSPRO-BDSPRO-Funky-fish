from unit import Unit

class SortingLine(Unit):
    """
    Sorting line unit that sorts the cargo by the color
    """
    def __init__(self,
                 name: str = "Sorting line",
                 station: str = "sld",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)