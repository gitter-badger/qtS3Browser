#!/bin/bash
if [ -z "$API_KEY" ]; then
  echo 'Please export your bintray api key as env variable API_KEY: export API_KEY="0000000000000000"'
  exit
fi

curl -v -T 'qts3browser_1.0.1_amd64.deb' -H 'X-Bintray-Debian-Distribution: stretch' -H 'X-Bintray-Debian-Component: main' -H 'X-Bintray-Debian-Architecture: amd64' -uarturfog:${API_KEY} https://api.bintray.com/content/arturfog/oss-arturfog/qts3browser/1.0.1/qts3browser_1.0.1_amd64.deb
