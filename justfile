_default:
  @just list

clean:
  rm -rf releases

build: clean
  #!/usr/bin/env bash
  whiskers ./templates/chrome.tera
  whiskers ./templates/chrome-store.tera
  for flavor in $(whiskers --list-flavors -o plain); do
    mkdir -p "./themes/$flavor/google-store/images/"
    cp -r ./templates/images/* "./themes/$flavor/google-store/images/"
    for accent in $(whiskers --list-accents -o plain); do
      mkdir -p "./themes/$flavor/$accent/images/"
      cp -r ./templates/images/* "./themes/$flavor/$accent/images/"
    done
  done

zip: build
  #!/usr/bin/env bash
  mkdir releases
  for flavor in $(whiskers --list-flavors -o plain); do
    zip -r "releases/catppuccin-chrome-$flavor-google-store.zip" "./themes/$flavor/google-store/"
    for accent in $(whiskers --list-accents -o plain); do
      zip -r "releases/catppuccin-chrome-$flavor-$accent.zip" "./themes/$flavor/$accent/"
    done
  done
