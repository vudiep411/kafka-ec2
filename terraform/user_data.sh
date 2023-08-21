#!/bin/bash
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk-devel
  # Download and install Kafka (replace the URL with the actual Kafka download link)
wget https://archive.apache.org/dist/kafka/3.5.1/kafka_2.12-3.5.1.tgz
tar -xzf kafka_2.12-3.5.1.tgz

# cd kafka_2.12-3.5.1

