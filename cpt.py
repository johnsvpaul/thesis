import json
from textwrap import indent
import requests


api_url = 'https://api.helium.io/v1/hotspots/11X7VqpmncBGaTS3cXwseV7Tt2HmwTBkp2XGgVPgJ5iAXGUc7FF/activity'
r = requests.get(api_url)
data = json.loads(r.text)
cursor = data['cursor']
print(cursor)


extract = data['data']

f = open("witnessess.txt", "w")

for time in extract:
  t = time['type']
  #print(t)
  f.write(t[0:10] + "\n")
f.close()

#print(extract)