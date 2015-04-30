#!/bin/sh 
DEMO="JBoss Fuse Travel Agency Demo"
VERSION=6.1.1
AUTHORS="Christina Lin"
PROJECT="git@github.com/weimeilin79/travelagency.git"
FUSE=jboss-fuse-6.1.1.redhat-412
FUSE_BIN=jboss-fuse-full-6.1.1.redhat-412.zip
DEMO_HOME=./target
FUSE_HOME=$DEMO_HOME/$FUSE
FUSE_PROJECT=./project/parent
FUSE_SERVER_CONF=$FUSE_HOME/etc
FUSE_SERVER_SYSTEM=$FUSE_HOME/system
FUSE_SERVER_BIN=$FUSE_HOME/bin
SRC_DIR=./installs
PRJ_DIR=./projects/twitterdemo


# wipe screen.
clear 

# add executeable in installs
chmod +x installs/*.zip


echo
echo "#################################################################"
echo "##                                                             ##"   
echo "##  Setting up the ${DEMO}               ##"
echo "##                                                             ##"   
echo "##                                                             ##"   
echo "##                #####  #   #  #####  #####                   ##"
echo "##                #      #   #  #      #                       ##"
echo "##                #####  #   #  #####  ####                    ##"
echo "##                #      #   #      #  #                       ##"
echo "##                #      #####  #####  #####                   ##"
echo "##                                                             ##"   
echo "##                                                             ##"   
echo "##  brought to you by,                                         ##"   
echo "##                    ${AUTHORS}                            ##"
echo "##                                                             ##"   
echo "##  ${PROJECT}                ##"
echo "##                                                             ##"   
echo "#################################################################"
echo

# double check for maven.
command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$FUSE_BIN || -L $SRC_DIR/$FUSE_BIN ]]; then
		echo $DEMO FUSE is present...
		echo
else
		echo Need to download $FUSE_BIN package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi


# Create the target directory if it does not already exist.
if [ ! -x $DEMO_HOME ]; then
		echo "  - creating the demo home directory..."
		echo
		mkdir $DEMO_HOME
else
		echo "  - detected demo home directory, moving on..."
		echo
fi


# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $FUSE_HOME ]; then
		echo "  - existing JBoss FUSE detected..."
		echo
		echo "  - moving existing JBoss FUSE aside..."
		echo
		rm -rf $FUSE_HOME.OLD
		mv $FUSE_HOME $FUSE_HOME.OLD

		# Unzip the JBoss instance.
		echo Unpacking JBoss FUSE $VERSION
		echo
		unzip -q -d $DEMO_HOME $SRC_DIR/$FUSE_BIN
else
		# Unzip the JBoss instance.
		echo Unpacking new JBoss FUSE...
		echo
		unzip -q -d $DEMO_HOME $SRC_DIR/$FUSE_BIN
fi



echo "  - enabling demo accounts logins in users.properties file..."
echo
cp support/users.properties $FUSE_SERVER_CONF


echo "  - copying a hacked org.apache.servicemix.bundles.spring-orm-3.2.9.RELEASE_1.jar file into syste,..."
echo
cp support/org.apache.servicemix.bundles.spring-orm-3.2.9.RELEASE_1.jar $FUSE_SERVER_SYSTEM/org/apache/servicemix/bundles/org.apache.servicemix.bundles.spring-orm/3.2.9.RELEASE_1/

echo "  - create h2 database file..."
echo

if [ -x ~/h2 ]; then
	rm -rf ~/h2/travelagency.mv.db
else
	mkdir ~/h2
fi

cp support/data/travelagency.mv.db ~/h2/


echo "  - making sure 'FUSE' for server is executable..."
echo
chmod u+x $FUSE_HOME/bin/start

cd target/$FUSE

echo "  - Start up Fuse in the background"
echo
sh bin/start

sleep 15

echo "  - Create Fabric in Fuse"
echo
sh bin/client -r 3 -d 50 -u admin -p admin 'fabric:create --wait-for-provisioning'

pwd

echo "Go to Project directory"
echo      
cd ../../$FUSE_PROJECT 

echo "Start compile and deploy 3 travel agency camel demo project to fuse"
echo         
mvn fabric8:deploy


cd ../../target/$FUSE

sleep 15 

echo "Create containers and add profiles for Flight web service endpoint"
echo         
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-webendpoint root wsflightcon'

echo "Create containers and add profiles for Hotel web service endpoint"
echo         
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-hotelwsendpoint root wshotelcon'

echo "Create containers and add profiles for flight booking service"
echo         
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-bookingservice root bookingflightcon'

echo "Create containers and add profiles for hotel booking service"
echo         
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-hotelbookingservice root bookinhotelgcon'

echo "Create containers and add profiles flight promotion"
echo
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-promotionflight root promoflightcon'

echo "Create containers and add profiles hotel promotion"
echo
sh bin/client -r 2 -d 40 'container-create-child --profile demo-travelagency-promotionhotel root promohotelcon'

echo "To stop the backgroud Fuse process, please go to bin and execute stop"
echo