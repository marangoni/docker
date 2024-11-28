#!/bin/bash

# Verifica se um argumento foi fornecido (versão)
if [ -z "$1" ]; then
  echo "Por favor, forneça a versão, por exemplo: ./docker_build.sh v3"
  exit 1
fi

# A variável VERSION vai pegar o primeiro argumento da linha de comando
VERSION=$1

# Executa o comando docker build com a versão fornecida
docker build -t lmarangoni75/ros:$VERSION .
