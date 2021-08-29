#!/bin/bash

# docdo-client ====
#
# - require jq
# install-jq https://stedolan.github.io/jq/download/
# $ brew install jq
#
# - set token
# export DOCDO_TOKEN={value}
#
# - run
# $ docdoc.sh cmd profile project file($1)

if [ "$#" -ne 4 ]; then
    echo "Usage: docdoc.sh gen 1001(PROFILE-ID) dokdo(PROJECT-NAME) FILE-PATH"
    exit 1
fi
if ! [ -e "$4" ]; then
    echo "$4 file not found"
    exit 1
fi

cmd="$1"
profile_id="$2"
project_name="$3"
file_path="$4"

#token="$DOCDO_TOKEN"
token="d1-76f9a278053739d15e828ff387ab841..."
uri="http://localhost:5000/api/v1/pf/${profile_id}/p/${project_name}/generate"
backup_path="$(eval echo "~")/data/developer/docdo-bak/$(date +'%Y%m%d%H%M%S')"
echo "run docdo-client.."

# resp=$(curl -s -w "%{http_code}" http://localhost:5000/static/common/test.json)
resp=$(curl -s -w "%{http_code}" -H "x-docdo-token: ${token}" -F "file=@${file_path}" "${uri}")
body=${resp:0:${#resp} - 3}
status=$(echo $resp | tail -c 4)

if [[ "$status" -ne 200 ]] ; then
    echo "status error: $body"
else
    cnt=$(echo "${body}" | jq '[.data[]] | length ')
    for (( i = 0; i < $cnt; i++ )); do
        data_id=$(echo "${body}" | jq -r --argjson v $i '.data[$v].id' )
        data_val=$(echo "${body}" | jq -r --argjson v $i '.data[$v].val' )

        if [ $data_id = "out" ]; then
            echo "$file_path"
            # backup
            if [ -e "$file_path" ]; then
                file_name=$(basename "${file_path}")
                echo "backup-out $file_name"
                if [ ! -d "$backup_path" ]; then
                    mkdir -p "$backup_path"
                fi
                cp ${file_path} "${backup_path}/${file_name}"
            fi

            echo "$data_val" > "$file_path"
        else
            echo "$data_id"
            # backup
            if [ -e "$data_id" ]; then
                file_name=$(basename "${data_id}")
                echo "backup $file_name"
                if [ ! -d "$backup_path" ]; then
                    mkdir -p "$backup_path"
                fi
                cp ${data_id} "${backup_path}/${file_name}"
            fi

            folder=$(dirname "${data_id}")
            if [ ! -d "$folder" ] ; then
                mkdir -p "$folder"
            fi
            echo "$data_val" > "$data_id"
        fi
    done
fi

echo 'done.'
exit 0
