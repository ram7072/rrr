import time

import pandas as pd
import requests
from pandas import DataFrame
import numpy as np
from io import BytesIO
from json import dumps
from datetime import datetime as dt
noaa_codes = [
    'KAST',
    'KBDN',
    'KCVO',
    'KEUG',
    'KHIO',
    'KHRI',
    'KMMV',
    'KONP',
    'KPDX',
    'KRDM',
    'KSLE',
    'KSPB',
    'KTMK',
    'KTTD',
    'KUAO'
]
urls = [f"https://api.weather.gov/stations/{x}/observations/latest" for x in noaa_codes]
file = [line.strip() for line in urls]
def reshape(r):
    cor=r["geometry"]
    props = r["properties"]
    res = {
        "X_COORDINATES":cor["coordinates"][0],
        "Y_COORDINATES":cor["coordinates"][1],
        "STATION": props["station"].split("/")[-1],
        "txd":props["textDescription"],
        "CELSIUS_TEMP": props["temperature"]["value"],
        "DEWPOINT": props["dewpoint"]["value"],
        "SEALEVELPRESSURE": props["seaLevelPressure"]["value"],
        "BAROMETRICPRESSURE": props["barometricPressure"]["value"],
        "PRCPLH":props["precipitationLastHour"]["value"],
        "VISIBILITY": props["visibility"]["value"],
        "WINDSPEED": props["windSpeed"]["value"],
        "WINDGUST": props["windGust"]["value"],
        "HUMIDITY": props["relativeHumidity"]["value"],
        "WINDDIRECTION": props["windDirection"]["value"]
    }
    return res


responses = []
try:
    for url in file:
        r = requests.get(url,verify=True)
        while r.status_code == 404:
            print("The URL is not hit")
            time.sleep(6)
            if r.status_code != 404:
                print("the URl is HIT ")
                responses.append(reshape(r.json()))
                print(responses)
except Exception as e :
    print(e)

