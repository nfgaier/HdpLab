patch /usr/hdp/current/falcon-server/webapp/falcon/js/falcon.js < FALCON-915-v1.patch
patch /usr/hdp/current/falcon-server/webapp/falcon/js/falcon-lineage.js < FALCON-945.patch


echo "Creating directories for temporary files..."

su -l hdfs -c "hadoop fs -mkdir -p /apps/falcon/horton/staging"
su -l hdfs -c "hadoop fs -chown falcon /apps/falcon/horton/staging"
su -l hdfs -c "hadoop fs -chmod 777 /apps/falcon/horton/staging"
su -l hdfs -c "hadoop fs -mkdir -p /apps/falcon/horton/working"
su -l hdfs -c "hadoop fs -chown falcon /apps/falcon/horton/working"


su -l hdfs -c "hadoop fs -mkdir -p /apps/falcon/horton-bkp/staging"
su -l hdfs -c "hadoop fs -chown falcon /apps/falcon/horton-bkp/staging"
su -l hdfs -c "hadoop fs -chmod 777 /apps/falcon/horton-bkp/staging"
su -l hdfs -c "hadoop fs -mkdir -p /apps/falcon/horton-bkp/working"
su -l hdfs -c "hadoop fs -chown falcon /apps/falcon/horton-bkp/working"


su -l hdfs -c "hadoop fs -mkdir -p /user/root"
su -l hdfs -c "hadoop fs -chown root:root /user/root"
date1=`date -d "0 days" +"%Y-%m-%d"`
date2=`date -d "1 days" +"%Y-%m-%d"`

sed "s/DATE1/$date1/" data-feed.xml.sample > data-feed.xml.new
sed "s/DATE2/$date2/" data-feed.xml.new > data-feed.xml
rm -rf data-feed.xml.new


echo "Done!"
echo "  "

