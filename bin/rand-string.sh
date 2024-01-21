#!/usr/bin/env bash

main() {

  local sampleSpace="0123456789abcdefghijklmnopqrstuvwxyz"
  
  _rand_char() {
    echo $sampleSpace | grep -o . | shuf -n1
  }
    
  local x=""
  
  for i in {0..10}; do
    x="${x}$(_rand_char)"
  done

  echo "${x}"
    
}

main 10
