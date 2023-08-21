import json
from confluent_kafka import Consumer, KafkaError
from dotenv import load_dotenv
import os

load_dotenv()
IP = os.getenv("BOOTSTRAP_SERVER")
TOPIC = 'topic1'
BROKER_ADDRESS = f"{IP}:9092"

config = {
    'bootstrap.servers': BROKER_ADDRESS,  # Replace with your Kafka broker's address
    'group.id': 'my_consumer_group',
    'auto.offset.reset': 'earliest'  # Start consuming from the earliest available offset
}

# Function to process the received JSON data
def process_json_data(data):
    try:
        json_data = json.loads(data)
        print(f'Received JSON data: {json_data}')
    except json.JSONDecodeError:
        print(f'Error decoding JSON data: {data}')



consumer = Consumer(config)
consumer.subscribe([TOPIC])

try:
    while True:
        msg = consumer.poll(1.0)

        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                print(f'End of partition reached: {msg.topic()} [{msg.partition()}]')
            else:
                print(f'Error while consuming: {msg.error()}')
        else:
            # Decode the message bytes and process JSON data
            data = msg.value().decode('utf-8')
            process_json_data(data)

except KeyboardInterrupt:
    pass
finally:
    consumer.close()