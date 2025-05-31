#!/bin/sh

get_artists() {
  echo "$playback" |
    jq .item.artists.[].name |
    sed -e "s/\"//g" |
    sed -e ":a; N; s/\n/, /g; ta"
}

get_song() {
  echo "$playback" |
    jq .item.name |
    sed -e "s/\"//g"
}

playback=$(spotify_player get key playback)

echo "$(get_song) · $(get_artists)"
