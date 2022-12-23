#!/bin/bash

# registered as a post-merge hook

echo
echo "Downloading external files"
echo

RETURN_CODE=0

readarray -d '' DLME_FILES < <(find . -name '*.DOWNLOAD_ME' -print0)

for DLME_FILE in "${DLME_FILES[@]}"; do
  URL="$(cat "$DLME_FILE")"
  FILE="${DLME_FILE%.DOWNLOAD_ME}"
  SUM="$(echo $URL | awk -F'[./]' '{print $(NF-1)}')"
  if [ -f "$FILE" ] && [ "$(sha256sum "$FILE" | cut -d' ' -f1)" == "$SUM" ]; then
    echo "👍  $FILE: Already up-to-date"
    continue
  else
    echo
    echo "📥  $FILE: downloading..."
    wget "$URL" -O "$FILE"
    
    WGET_OK=$([ "$?" == 0 ] && echo 1)
    CHECKSUM_OK=$([ "$(sha256sum "$FILE" | cut -d' ' -f1)" == "$SUM" ] && echo 1)
  
    [ $WGET_OK ] && [ ! $CHECKSUM_OK ] && echo -e "\e[31m❌ Checksum does not match!\e[0m"
    
    if [ $CHECKSUM_OK ] && [ $WGET_OK ]; then
      echo "👍  $FILE: Download succeeded"
    else
      echo -e "\e[31m❌ $FILE: Download FAILED!\e[0m"
      RETURN_CODE=-1
      rm "$FILE" >& /dev/null
    fi
    echo
  fi
done

echo
echo "Done downloading external files"
[ "$RETURN_CODE" == "0" ] || echo -e "\e[31m❌ Not all files have been downloaded successfully. Try to relaunch ./download.sh\e[0m"
echo
exit $RETURN_CODE