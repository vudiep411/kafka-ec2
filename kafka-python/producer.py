import pandas as pd
from time import sleep
from confluent_kafka import Producer
import json
from dotenv import load_dotenv
import os

load_dotenv()
IP = os.getenv("BOOTSTRAP_SERVER")

TOPIC = 'topic1'
BROKER_ADDRESS = f"{IP}:9092"
config = { 'bootstrap.servers': BROKER_ADDRESS }


producer = Producer(config)

def delivery_report(err, msg):
    if err is not None:
        print(f'Message delivery failed: {err}')
    else:
        print(f'Message delivered to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}')

# Grab data from csv
df = pd.read_csv("real_time.csv")

while True:
    idx_data = df.sample(1).to_dict(orient="records")[0]
    message = json.dumps(idx_data).encode('utf-8')
    producer.produce(TOPIC, message, callback=delivery_report)
    sleep(1)
