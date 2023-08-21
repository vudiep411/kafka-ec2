#!/bin/bash

sudo apt-get update
sudo apt-get install -y default-jre
  # Download and install Kafka (replace the URL with the actual Kafka download link)
wget https://archive.apache.org/dist/kafka/3.5.1/kafka_2.12-3.5.1.tgz
tar -xzf kafka_2.12-3.5.1.tgz

# cd kafka_2.12-3.5.1

