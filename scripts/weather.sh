#!/usr/bin/env bash

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CWD/tmux.sh"

cache_file=~/.tmux-weather
cache_ttl=900

weather() {
  if [[ -f "$cache_file" ]]; then
    local NOW=$(date +%s)
    local MOD=$(date -r "$cache_file" +%s)
    if [[ $(( $NOW - $MOD )) -gt $cache_ttl ]]; then
      rm "$cache_file"
    fi
  fi

  if [[ ! -f "$cache_file" ]]; then
    URL='https://query.yahooapis.com/v1/public/yql'
    GEO=$(curl -s https://ipinfo.io | jq -r '.loc')
    QUERY='select item.condition from weather.forecast where woeid in (select woeid from geo.places where text="('$GEO')")'
    read CODE DEGREES <<< $(curl -Gs $URL --data-urlencode "q=$QUERY" -d format=json | jq -r '.query.results.channel.item.condition | .code + " " + .temp')
    case "$CODE" in
      9|1[0-2])  ICON="☂";;
      2[6-9]|30) ICON="☁";;
      3[2-4])    ICON="☀";;
      *)         ICON="";;
    esac
    local WEATHER="${DEGREES}°"
    [[ -n "$ICON" ]] && WEATHER="$WEATHER $ICON "
    echo "${WEATHER}" >"$cache_file"
  fi
  cat "$cache_file"
}

main() {
  weather
}

main
