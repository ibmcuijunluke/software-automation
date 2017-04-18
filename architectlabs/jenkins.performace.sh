
echo /opt/apache-jmeter/apache-jmeter-2.13/results/jtl
cd /opt/apache-jmeter/apache-jmeter-2.13/results/jtl
rm -rf *
cd /opt/apache-jmeter/apache-jmeter-2.13/results/html
rm -rf *

export ANT_HOME=/opt/apache-jmeter/apache-ant-1.9.7
cd /opt/apache-jmeter/apache-jmeter-2.13
ant -version
ant -buildfile build_cloudwisdom.xml
echo "ant jmetyer testing has been done."
cd /opt/apache-jmeter/apache-jmeter-2.13/results/jtl
ls
cp -r TestReport*.jtl $WORKSPACE/
cd /opt/apache-jmeter/apache-jmeter-2.13/results/html
ls
cp -r *.png $WORKSPACE/
cp -r TestReport*.html $WORKSPACE/
echo $WORKSPACE
