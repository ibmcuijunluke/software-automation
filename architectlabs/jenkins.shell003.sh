#excute automation testing framework
#author cuijun 20161128

cd $WORKSPACE
cd jw_testcase
python testsuit_interface_sample.py


find /opt/apache-packages/ -name "*.sql" -exec rm -rf {} \;

find /opt/jwsqldir/ -name "*.sql" | xargs -i cp {} /opt/apache-packages/
echo "move sql files has been done"

cd $WORKSPACE/test-report
ls

cd $WORKSPACE/apache-jmeter/apache-jmeter-2.13
ls -ll

#echo $WORKSPACE/apache-jmeter/apache-jmeter-2.13/results/jtl
#cd $WORKSPACE/apache-jmeter/apache-jmeter-2.13/results/jtl
#rm -rf *
#cd $WORKSPACE/apache-jmeter/apache-jmeter-2.13/results/html
#rm -rf *

#export ANT_HOME=$WORKSPACE/apache-jmeter/apache-ant-1.9.7
#cd $WORKSPACE/apache-jmeter/apache-jmeter-2.13
#ant -version
#ant -buildfile build_cloudwisdom.xml
#echo "ant jmetyer testing has been done."


#cd /opt/apache-jmeter/apache-jmeter-2.13/results/jtl
#rm -rf *
#cd /opt/apache-jmeter/apache-jmeter-2.13/results/html
#rm -rf *

#export ANT_HOME=/opt/apache-jmeter/apache-ant-1.9.7
#cd /opt/apache-jmeter/apache-jmeter-2.13
#ant -version
#ant -buildfile build_cloudwisdom.xml
#echo "ant jmetyer testing has been done."
#./buildJmeter.sh
