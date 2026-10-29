from unit import Unit

class HighBayWarehouse(Unit):
    """
    High-bay warehouse unit that combines environment sensor and warehouse that stores the cargo
    """
    def __init__(self,
                 name:str = "High-bay warehouse",
                 station: str = "hbw",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)
