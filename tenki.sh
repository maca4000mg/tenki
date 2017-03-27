#if [ "$#" -ne 1 ]; then
#    echo "Usage:"
#    echo "  $1 tenki html file"
#    exit 1
#fi


tenki_html=28111-1hour.html # kobe nisiku
tenki_url=http://www.tenki.jp/forecast/6/31/6310/${tenki_html}
wget $tenki_url

# 72hours weather
weather=$(xmllint --html --xpath '//tr[@class="weather"]/td/p' $tenki_html 2>/dev/null \
    | perl -pi -e 's/^\s+$//g' | perl -pi -e 's/\<\/p\>/\<\/p\>\n/g' \
    | perl -pi -e 's/\<p[ a-z="]*\>(.*)\<\/p\>/$1/g')
echo weather:
echo $weather
echo

# 72hours temperature
temperature=$(xmllint --html --xpath '//tr[@class="temperature"]' $tenki_html 2>/dev/null \
    | grep "<td>" | perl -pi -e 's/^\s+$//g' \
    | perl -pi -e 's/\<td\>\<span.*\>([0-9\.]+)\<\/span\>\<\/td\>/$1/g')
echo temperature:
echo $temperature
echo

# 72hours precipitation probability
prob_precip=$(xmllint --html --xpath '//tr[@class="prob_precip"]' $tenki_html 2>/dev/null \
    | grep "<td>" | perl -pi -e 's/^\s+$//g' \
    | perl -pi -e 's/\<td\>\<span.*\>([0-9]+)\<\/span\>\<\/td\>/$1/g')

echo prob_precip:
echo $prob_precip
echo

