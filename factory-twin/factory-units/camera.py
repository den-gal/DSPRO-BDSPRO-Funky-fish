from unit import Unit

class Camera(Unit):
    """
    Camera unit that is able to rotate
    """
    def __init__(self,
                 name: str = "Camera",
                 station: str = "ptu",
                 code: int = 1,
                 target=None,
                 description=None,
                 active: bool = False):
        super().__init__(name, station, code, target, description, active)
        self.pan = float(0)
        self.tilt = float(0)
