_default:
  @just list

build:
  #!/usr/bin/env bash
  whiskers ./templates/chrome.tera
  whiskers ./templates/chrome-store.tera
  for flavor in $(whiskers --list-flavors -o plain ); do
    cp -r ./templates/images/* "./themes/$flavor/google-store/images/"
    for accent in $(whiskers --list-accents -o plain ); do
      cp -r ./templates/images/* "./themes/$flavor/$accent/images/"
    done
  done
