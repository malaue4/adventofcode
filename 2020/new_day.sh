#!/usr/bin/env sh
day=$1
if [[ -z $day ]]; then
  echo "Which day do you want to create files for?"
  read day
fi
echo "input = File.read('advent${day}input').lines(chomp: true)" > "advent${day}.rb"
touch "advent${day}input"

mine "advent${day}.rb"