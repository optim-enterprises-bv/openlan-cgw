#!/bin/bash

DEFAULT_ID=0
DEFAULT_LOG_LEVEL="info"

# By default - use default subnet's SRC ip to listen to gRPC requests
DEFAULT_SRC_IP=`ip route get 1 | grep -o "src\ .*\ " |  grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"`
DEFAULT_GRPC_PORT=50051

# By default - listen to all interfaces
DEFAULT_WSS_IP="0.0.0.0"
DEFAULT_WSS_PORT=15002
DEFAULT_WSS_THREAD_NUM=4

DEFAULT_CERTS_PATH="/etc/ssl/certs"
DEFAULT_WSS_CERT="cgw.crt"
DEFAULT_WSS_KEY="cgw.key"

DEFAULT_KAFKA_IP="127.0.0.1"
DEFAULT_KAFKA_PORT=9092
DEFAULT_KAFKA_CONSUME_TOPIC="CnC"
DEFAULT_KAFKA_PRODUCE_TOPIC="CnC_Res"

DEFAULT_DB_IP="127.0.0.1"
DEFAULT_DB_PORT=5432
DEFAULT_DB_NAME="cgw"
DEFAULT_DB_USER="cgw"
DEFAULT_DB_PASW="123"

DEFAULT_REDIS_DB_IP="127.0.0.1"
DEFAULT_REDIS_DB_PORT=6379

CONTAINTER_CERTS_VOLUME="/etc/cgw/certs"

export CGW_LOG_LEVEL="${CGW_LOG_LEVEL:-$DEFAULT_LOG_LEVEL}"
export CGW_ID="${CGW_ID:-$DEFAULT_ID}"
export CGW_WSS_IP="${CGW_WSS_IP:-$DEFAULT_WSS_IP}"
export CGW_WSS_PORT="${CGW_WSS_PORT:-$DEFAULT_WSS_PORT}"
export CGW_WSS_THREAD_NUM="${CGW_WSS_THREAD_NUM:-$DEFAULT_WSS_THREAD_NUM}"
export CGW_WSS_CERT="${CGW_WSS_CERT:-$DEFAULT_WSS_CERT}"
export CGW_WSS_KEY="${CGW_WSS_KEY:-$DEFAULT_WSS_KEY}"
export CGW_GRPC_IP="${CGW_GRPC_IP:-$DEFAULT_SRC_IP}"
export CGW_GRPC_PORT="${CGW_GRPC_PORT:-$DEFAULT_GRPC_PORT}"
export CGW_KAFKA_IP="${CGW_KAFKA_IP:-$DEFAULT_KAFKA_IP}"
export CGW_KAFKA_PORT="${CGW_KAFKA_PORT:-$DEFAULT_KAFKA_PORT}"
export CGW_KAFKA_CONSUME_TOPIC="${CGW_KAFKA_CONSUME_TOPIC:-$DEFAULT_KAFKA_CONSUME_TOPIC}"
export CGW_KAFKA_PRODUCE_TOPIC="${CGW_KAFKA_PRODUCE_TOPIC:-$DEFAULT_KAFKA_PRODUCE_TOPIC}"
export CGW_DB_IP="${CGW_DB_IP:-$DEFAULT_DB_IP}"
export CGW_DB_PORT="${CGW_DB_PORT:-$DEFAULT_DB_PORT}"
export CGW_DB_NAME="${CGW_DB_NAME:-$DEFAULT_DB_NAME}"
export CGW_DB_USERNAME="${CGW_DB_USER:-$DEFAULT_DB_USER}"
export CGW_DB_PASSWORD="${CGW_DB_PASS:-$DEFAULT_DB_PASW}"
export CGW_REDIS_IP="${CGW_REDIS_DB_IP:-$DEFAULT_REDIS_DB_IP}"
export CGW_REDIS_PORT="${CGW_REDIS_DB_PORT:-$DEFAULT_REDIS_DB_PORT}"
export CGW_CERTS_PATH="${CGW_CERTS_PATH:-$DEFAULT_CERTS_PATH}"

echo "Starting CGW..."
echo "CGW LOG LEVEL     : $CGW_LOG_LEVEL"
echo "CGW ID            : $CGW_ID"
echo "CGW WSS THREAD NUM: $CGW_WSS_THREAD_NUM"
echo "CGW WSS IP/PORT   : $CGW_WSS_IP:$CGW_WSS_PORT"
echo "CGW WSS CERT      : $CGW_WSS_CERT"
echo "CGW WSS KEY       : $CGW_WSS_KEY"
echo "CGW GRPC          : $CGW_GRPC_IP:$CGW_GRPC_PORT"
echo "CGW KAFKA IP/PORT : $CGW_KAFKA_IP:$CGW_KAFKA_PORT"
echo "CGW KAFKA TOPIC   : $CGW_KAFKA_CONSUME_TOPIC:$CGW_KAFKA_PRODUCE_TOPIC"
echo "CGW DB NAME       : $CGW_DB_NAME"
echo "CGW DB IP/PORT    : $CGW_DB_IP:$CGW_DB_PORT"
echo "CGW REDIS         : $CGW_REDIS_IP:$CGW_REDIS_PORT"
echo "CGW CERTS PATH    : $CGW_CERTS_PATH"

docker run \
	-v $CGW_CERTS_PATH:$CONTAINTER_CERTS_VOLUME \
	-e CGW_LOG_LEVEL           \
	-e CGW_ID                  \
	-e CGW_WSS_IP              \
	-e CGW_WSS_PORT            \
	-e CGW_WSS_THREAD_NUM      \
	-e CGW_WSS_CERT            \
	-e CGW_WSS_KEY             \
	-e CGW_GRPC_IP             \
	-e CGW_GRPC_PORT           \
	-e CGW_KAFKA_IP            \
	-e CGW_KAFKA_PORT          \
	-e CGW_KAFKA_CONSUME_TOPIC \
	-e CGW_KAFKA_PRODUCE_TOPIC \
	-e CGW_DB_NAME             \
	-e CGW_DB_IP               \
	-e CGW_DB_PORT             \
	-e CGW_DB_USERNAME         \
	-e CGW_DB_PASSWORD         \
	-e CGW_REDIS_IP            \
	-e CGW_REDIS_PORT          \
	-d -t --network=host --name $2 $1 ucentral-cgw
