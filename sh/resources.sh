#!/usr/bin/env bash

## root directories

root="resources"
mkdir -p "$root"
mkdir -p "$root/meta"
mkdir -p "$root/genbank"
mkdir -p "$root/blast"

## get AdV metadata from OneDrive

curl 'https://exchangelabsgmu-my.sharepoint.com/personal/dnegron2_masonlive_gmu_edu/_layouts/15/download.aspx?UniqueId=36aacf5a%2D86de%2D462d%2Dae59%2D1e6c040427fb' \
  --compressed \
  -H 'Connection: keep-alive' \
  -H 'Referer: https://exchangelabsgmu-my.sharepoint.com/personal/dnegron2_masonlive_gmu_edu/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fdnegron2%5Fmasonlive%5Fgmu%5Fedu%2FDocuments%2Fdissertation%2Fdata%2Fmeta' \
  -H 'Cookie: rtFa=eWX6Zym+6Dh0w9q3mjxt5Op1rd2hOZb1WAHiOCsbp+AmMTI2MzA2NzUtMUYwRC00MTFDLUFDRTUtQTc3Q0Q1RjQ4OTEybF9pUAhv+uMrhXjDp3OjaWNKg98emWOSCMYoHyrg0bvDw8fxJusWWovbDvUkE7RyyqQm9bCUtSzhrAqGfeSxVfB/Tr/7NTSnzdC2+8aK1uh58egDus/1TVXUk2eub3ZmH4+9celztsIfraKGiIy2E4NF6mhomgOt+6Pc8qeAY06G6h3QTiZdFh9UxZCujxI+yipsSkOG8OPcDx+Ojtf+Bfywjk/uBX4b4/GyAZeMYZewzobLnFF3Lff4PoHB4VNdkqtFWYE76cs67MX43jNrlu+G6hYRNY06AzJUcg5mLFJSMi8WxNtM1CzWXNBFxkrTkJ6TtdjrpQiuQYBm33vSCEUAAAA=; FedAuth=77u/PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48U1A+VjgsMGguZnxtZW1iZXJzaGlwfDEwMDMzZmZmODllZTYxNzFAbGl2ZS5jb20sMCMuZnxtZW1iZXJzaGlwfGRuZWdyb24yQG1hc29ubGl2ZS5nbXUuZWR1LDEzMjQzNTI0NzQ3MDAwMDAwMCwxMzIzNDU1OTc1NzAwMDAwMDAsMTMyNDM5NjEyODU0NDg1NDY1LDEwOC4yOC43LjE1MiwzLDEyNjMwNjc1LTFmMGQtNDExYy1hY2U1LWE3N2NkNWY0ODkxMiwsNTI4ZDQ2OGMtZDFhNi00N2E2LWI5MjItNWJkZTkwMTNhM2M5LDc2YjNkZGEyLTEyNDMtNDQ5NC1iZTIzLTU1NWEyYTM0NjE3Yyw3NmIzZGRhMi0xMjQzLTQ0OTQtYmUyMy01NTVhMmEzNDYxN2MsLDAsMTMyNDM2MTU2ODU0MTcyOTkzLDEzMjQzNzg4NDg1NDE3Mjk5MywsLGV5SjRiWE5mWTJNaU9pSmJYQ0pEVURGY0lsMGlmUT09LDI2NTA0Njc3NDM5OTk5OTk5OTksMTMyNDM1MjkyODQwMDAwMDAwLDhlMTk4NzgxLWU4NWQtNDVlMS1iY2U5LTkyNTdkNjc3ZWMxZCxLMTVqUUZlem1NUzNmQmZ6Z2ZtUWZsdEFKNkNnRGxYb25rWURobjVvS05tck85WjBUYWN3YUx0NUZsVGVwN2RhVUxsSjlvbEpSN3RvTUwxUG5IRWNPNkZEOXpaZDZhMEg5RC95dW1FcEdrWDYwRmNETDk4c044aHduc3QwN2lra2I2aW9YQXdCanNIYjFwVW4xZmJPbUVGK3ZJRTZjV3EyaGY4enZwOVNFQ1pEemdjejRXK2hpZHIwTVBzNmJmMlZ3T0ZHdUFQQzQ3OStlS3Nlbll1enFNNW8xdTJ5NlNvRVE3aHZqa0U5YmVrbEVmOHJaZy81T1JlOEpoWmEvdm1nV3RWbElPRVJpcGJYWHRHeUxJejQydTFoTE5adGxDaCt5WmltVkQyME5SbzEyaWZ5UStlL2Exc3lXdW1mZ1IwSzFKdGJTanpld1NhUm1FeXV5N2lCZnc9PTwvU1A+; CCSInfo=OS81LzIwMjAgNDoxMzowMyBQTaJcyJkIXc4ub/jt00x1SKyjkT1IGxZDcG/dEvP8zr4ZxEc9UdeBrx0Jef6d+neshXvDgvLz+fJlxyrknIdc5+TG7Mprcl1fRNChbz1Y8cZJaCGT92p7wR83n1qjDmFm6wlmH8s42+Su0X3OiVijObkj56c1W2qV6K5qfEfdFHZUTK1yOCEaaLY3smK7KpBShM9rXaY2V0sql43C6FINZ7yPrHmzKUZJbNVVwZM4Jfu8AaKn7YJfERA8+1E9IeP6Keo2R6x6ig6zSdK+K3RcTtT+2Fg7Fm1oBSivWj4qFgXpsPAip2sFVnnsDqai6Og0xasKIpopNVPg+2+FS+qTMNQTAAAA; cucg=1' \
  -o "$root/meta/HAdV.xlsx"

## get genbank database sequences from OneDrive

curl 'https://exchangelabsgmu-my.sharepoint.com/personal/dnegron2_masonlive_gmu_edu/_layouts/15/download.aspx?UniqueId=7f7249cb%2De77e%2D473f%2Dab47%2D153462deadc4' \
  --compressed \
  -H 'Connection: keep-alive' \
  -H 'Referer: https://exchangelabsgmu-my.sharepoint.com/personal/dnegron2_masonlive_gmu_edu/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fdnegron2%5Fmasonlive%5Fgmu%5Fedu%2FDocuments%2Fdissertation%2Fdata%2Fgenbank' \
  -H 'Cookie: rtFa=eWX6Zym+6Dh0w9q3mjxt5Op1rd2hOZb1WAHiOCsbp+AmMTI2MzA2NzUtMUYwRC00MTFDLUFDRTUtQTc3Q0Q1RjQ4OTEybF9pUAhv+uMrhXjDp3OjaWNKg98emWOSCMYoHyrg0bvDw8fxJusWWovbDvUkE7RyyqQm9bCUtSzhrAqGfeSxVfB/Tr/7NTSnzdC2+8aK1uh58egDus/1TVXUk2eub3ZmH4+9celztsIfraKGiIy2E4NF6mhomgOt+6Pc8qeAY06G6h3QTiZdFh9UxZCujxI+yipsSkOG8OPcDx+Ojtf+Bfywjk/uBX4b4/GyAZeMYZewzobLnFF3Lff4PoHB4VNdkqtFWYE76cs67MX43jNrlu+G6hYRNY06AzJUcg5mLFJSMi8WxNtM1CzWXNBFxkrTkJ6TtdjrpQiuQYBm33vSCEUAAAA=; FedAuth=77u/PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48U1A+VjgsMGguZnxtZW1iZXJzaGlwfDEwMDMzZmZmODllZTYxNzFAbGl2ZS5jb20sMCMuZnxtZW1iZXJzaGlwfGRuZWdyb24yQG1hc29ubGl2ZS5nbXUuZWR1LDEzMjQzNTI0NzQ3MDAwMDAwMCwxMzIzNDU1OTc1NzAwMDAwMDAsMTMyNDM5NjEyODU0NDg1NDY1LDEwOC4yOC43LjE1MiwzLDEyNjMwNjc1LTFmMGQtNDExYy1hY2U1LWE3N2NkNWY0ODkxMiwsNTI4ZDQ2OGMtZDFhNi00N2E2LWI5MjItNWJkZTkwMTNhM2M5LDc2YjNkZGEyLTEyNDMtNDQ5NC1iZTIzLTU1NWEyYTM0NjE3Yyw3NmIzZGRhMi0xMjQzLTQ0OTQtYmUyMy01NTVhMmEzNDYxN2MsLDAsMTMyNDM2MTU2ODU0MTcyOTkzLDEzMjQzNzg4NDg1NDE3Mjk5MywsLGV5SjRiWE5mWTJNaU9pSmJYQ0pEVURGY0lsMGlmUT09LDI2NTA0Njc3NDM5OTk5OTk5OTksMTMyNDM1MjkyODQwMDAwMDAwLDhlMTk4NzgxLWU4NWQtNDVlMS1iY2U5LTkyNTdkNjc3ZWMxZCxLMTVqUUZlem1NUzNmQmZ6Z2ZtUWZsdEFKNkNnRGxYb25rWURobjVvS05tck85WjBUYWN3YUx0NUZsVGVwN2RhVUxsSjlvbEpSN3RvTUwxUG5IRWNPNkZEOXpaZDZhMEg5RC95dW1FcEdrWDYwRmNETDk4c044aHduc3QwN2lra2I2aW9YQXdCanNIYjFwVW4xZmJPbUVGK3ZJRTZjV3EyaGY4enZwOVNFQ1pEemdjejRXK2hpZHIwTVBzNmJmMlZ3T0ZHdUFQQzQ3OStlS3Nlbll1enFNNW8xdTJ5NlNvRVE3aHZqa0U5YmVrbEVmOHJaZy81T1JlOEpoWmEvdm1nV3RWbElPRVJpcGJYWHRHeUxJejQydTFoTE5adGxDaCt5WmltVkQyME5SbzEyaWZ5UStlL2Exc3lXdW1mZ1IwSzFKdGJTanpld1NhUm1FeXV5N2lCZnc9PTwvU1A+; CCSInfo=OS81LzIwMjAgNDoxMzowMyBQTaJcyJkIXc4ub/jt00x1SKyjkT1IGxZDcG/dEvP8zr4ZxEc9UdeBrx0Jef6d+neshXvDgvLz+fJlxyrknIdc5+TG7Mprcl1fRNChbz1Y8cZJaCGT92p7wR83n1qjDmFm6wlmH8s42+Su0X3OiVijObkj56c1W2qV6K5qfEfdFHZUTK1yOCEaaLY3smK7KpBShM9rXaY2V0sql43C6FINZ7yPrHmzKUZJbNVVwZM4Jfu8AaKn7YJfERA8+1E9IeP6Keo2R6x6ig6zSdK+K3RcTtT+2Fg7Fm1oBSivWj4qFgXpsPAip2sFVnnsDqai6Og0xasKIpopNVPg+2+FS+qTMNQTAAAA; cucg=1' | \
  tar xf - -C "$root/genbank"

## genbank database metadata

python -m ffbio.ffidx "$root"/genbank/10508.db -dump -fo gb | \
  python -m ffbio.ffqual - organism collection_date country | \
  ndate.R - $'\t' date %Y-%m-%d collection_date dbY Ymd bY Y | \
  ngeon.R - $'\t' country "[:,]" > \
  "$root"/genbank/10508.tsv

## blast database

python -m ffbio.ffidx "$root"/genbank/10508.db -dump -fo gb | \
  python -m ffbio.ffqual - db_xref | \
  awk -F '\t' 'NR > 1 { match($2, /taxon:([0-9]+)/, arr); print $1, arr[1] ? arr[1] : 0; }' > \
  "$root"/blast/10508.ssv

rm -f "$root"/blast/10508.log

python -m ffbio.ffidx "$root"/genbank/10508.db -dump | \
  makeblastdb \
    -in - -dbtype nucl \
    -title 10508 -out "$root"/blast/10508 \
    -parse_seqids -hash_index -blastdb_version 5 \
    -taxid_map "$root"/blast/10508.ssv -logfile "$root"/blast/10508.log
