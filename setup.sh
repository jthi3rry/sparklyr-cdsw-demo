# Make download directory
mkdir /tmp/flights

# Download flight data by year
for i in {2006..2008}
  do
    echo "$(date) $i Download"
    fnam=$i.csv.bz2
    wget -O /tmp/flights/$fnam http://stat-computing.org/dataexpo/2009/$fnam
    echo "$(date) $i Unzip"
    bzip2 -d /tmp/flights/$fnam
  done

# Download airline carrier data
wget -O /tmp/airlines.csv http://www.transtats.bts.gov/Download_Lookup.asp?Lookup=L_UNIQUE_CARRIERS

# Download airports data
wget -O /tmp/airports.csv https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat

hdfs dfs -put /tmp/flights /tmp/flights
hdfs dfs -put /tmp/airlines.csv /tmp/airlines.csv
hdfs dfs -put /tmp/airports.csv /tmp/airports.csv

hive -f setup.hql
