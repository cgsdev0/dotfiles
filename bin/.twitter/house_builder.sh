#!/usr/bin/env bash

function house_builder() {
  # floors,rooms,has_garage
  echo "0,0,0"
}

function set_field() {
  local f r g
  IFS=, read f r g
  printf -v "$1" "%s" "$2"
  echo "$f,$r,$g"
}

function floors() {
  set_field f $1
}

function rooms() {
  set_field r $1
}

function has_garage() {
  set_field g $1
}

function build() {
  local f r g h i j k
  IFS=, read f r g
  local rpf=$((r / f))
  local remainder=$((r % f))
  local w=$((rpf + remainder))
  local gws="    "
  h=$((w+1+f))
  k=0

  function garage() {
    [[ $((h-k)) -eq 3 ]] && gws=' __ '
    [[ $((h-k)) -eq 2 ]] && gws='/__\'
    [[ $((h-k)) -eq 1 ]] && gws='|🚘|'
    [[ $g == "true" ]] && echo -n "$gws"
  }

  # every good house starts with a roof
  for (( i=0; i<=w; i++,k++ )); do
    garage
    printf '%*s' $((w - i))
    [[ $i -eq 0 ]] && echo "_"
    [[ $i -ne 0 ]] && echo -n "/"
    printf -v pad '%*s' $((i*2-1))
    [[ $i -eq $w ]] && pad=${pad// /_}
    [[ $i -ne 0 ]] && echo -n "$pad"
    [[ $i -ne 0 ]] && echo "\\"
  done

  # main part of the house
  for (( i=0; i<f; i++,k++ )); do
    garage
    for (( j=0; j<w; j++ )); do
      filled=_
      [[ $i -ne 0 ]] && [[ $j -ge $rpf ]] && filled="#"
      echo -n "|$filled"
    done
    echo "|"
  done
}

house_builder \
  | floors 6 \
  | rooms 5 \
  | has_garage true \
  | build
