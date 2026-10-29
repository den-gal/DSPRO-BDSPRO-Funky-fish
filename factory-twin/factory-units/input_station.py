from unit import Unit

class InputStation(Unit):
    """
    Input station unit that receives cargo for the warehouse
    """
    def __init__(self,
                 name: str = "Input station",
                 station: str = "dsi",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)