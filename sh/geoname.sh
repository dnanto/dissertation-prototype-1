## geoname

rm -f data/geonames/geoname.db

cat << 'EOF' > data/geoname/geoname.sql
CREATE VIRTUAL TABLE geoname USING FTS5 (geonameid, name, class, code, cc2, ac1, ac2, ac3, ac4);
.mode tabs
.import /dev/stdin geoname
EOF
unzip -p data/geoname/allCountries.zip | \
    awk -F '\t' -v OFS='\t' '$8 ~ /ADM[1-5D]H?/ { print $1, $3, $7, $8, $9, $11, $12, $13, $14; }' | \
    sqlite3 --init data/geoname/geoname.sql data/geoname/geoname.db

cat << 'EOF' > data/geoname/altname.sql
CREATE VIRTUAL TABLE altname USING FTS5 (geonameid, name);
.mode tabs
.import /dev/stdin altname
EOF
unzip -p data/geoname/allCountries.zip | \
    awk -F '\t' -v OFS='\t' '$8 ~ /ADM[1-5D]H?/ && length($4) { split($4, t, ","); for (i in t) print $1, t[i]; }' | \
    sqlite3 --init data/geoname/altname.sql data/geoname/geoname.db

cat << 'EOF' > data/geoname/country.sql
CREATE VIRTUAL TABLE country USING FTS5 (cc2, cc3, cn);
.mode tabs
.import /dev/stdin country
EOF
awk -F '\t' -v OFS='\t' '/^[^#]/ { print $1, $2, $5 }' data/geoname/countryInfo.txt | \
    sqlite3 --init data/geoname/country.sql data/geoname/geoname.db
