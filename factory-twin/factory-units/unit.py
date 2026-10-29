class Unit:
    """
    Template class for units of the factory.
    """

    def __init__(self, station:str, code:str, target = None, description = None, active:bool=False):
        """
        Args:
            station: the name of the station (hbw/vgr/mpo/sld/dsi/dso/fct)
            code: status or error code
            description: description of the station (nullable, usually empty)
            target: nullable, only set for vgr code=2
            active: boolean status of the station
        """
        self.station = station
        self.code = code
        self.active = active
        self.description = description
        self.active_timestamp = None
        self.inactive_timestamp = None
        self.target = target