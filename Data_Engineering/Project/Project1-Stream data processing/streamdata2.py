import requests
from bs4 import BeautifulSoup
import keyboard
import time as t
import pandas as pd
import asyncio
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData
import json

def datasource():
    url="https://www.meteoblue.com/en/weather/week/navi-mumbai_india_6619347"

    html = requests.get(url).content
    
    soup = BeautifulSoup(html,'html.parser')
    temp = soup.find('div',attrs={'class':'h1 current-temp'}).text
    t.sleep(60)
    dataframe=pd.DataFrame([[temp]],columns=['temperature'])
    print(dataframe)
    return dataframe.to_dict('records')
datasource()

async def run():

    while True:
        await asyncio.sleep(5)
        producer = EventHubProducerClient.from_connection_string(conn_str='Endpoint=sb://receivestreamingdata.servicebus.windows.net/;  \
                                                                 SharedAccessKeyName=policy;SharedAccessKey=nB6TuAiNsZ+Ayyb0vB7K13d2Bo/Jv5GM5+AEhLLy3is=; \
                                                                 EntityPath=getdata',eventhub_name='getdata')
        async with producer:
            
            event_data_batch = await producer.create_batch()
            
            event_data_batch.add(EventData(json.dumps(datasource())))
            
            await producer.send_batch(event_data_batch)
            print('1076-Data has been sent successfully to eventhubs!!')

loop = asyncio.get_event_loop()
try:
    asyncio.ensure_future(run())
    loop.run_forever()
except KeyboardInterrupt:
    pass
finally:
    print('Closing')
    loop.close()