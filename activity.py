import requests
import time
cursor=""

for i in range(10000):
# api-endpoint
    URL = "https://api.helium.io/v1/hotspots/11X7VqpmncBGaTS3cXwseV7Tt2HmwTBkp2XGgVPgJ5iAXGUc7FF/roles?cursor="

# sending get request and saving the response as response object
    r = requests.get(url = URL + cursor)

# extracting data in json format

    data = r.json()
   #print(data)
    
    for index, items in enumerate(data["data"]):
        type = data["data"][index]['type']
        if (type =='poc_receipts_v2'):
            #packets = data["data"][index]["state_channel"]["summaries"][0]["num_packets"]
            role = data["data"][index]['role']
            date = data["data"][index]['time']
            f = open("witnessess.csv", "a")
            f.write(str(role) + "," + str(date) + "\n")
            print(str(role) + "," + str(date))


    cursor = data["cursor"]
    #print("Cursor: ", cursor)
    time.sleep(1) 
    
print("END")