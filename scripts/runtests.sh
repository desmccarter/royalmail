#!/bin/bash

# AUTHOR		: Des McCarter @ BJSS
# DATE			: 09/09/2017
# DESCRIPTION		: Trigger seleniod tests


# Notes:
#
# Wehsphere and Selendroid Paths HAVE to be absolute. Since the project path changes, depending on which
# machine this is running on and which user, both these library paths depend on $CURRENT_FOLDER_WINDOWS. This also
# means that this script needs to be run in the root project folder (i.e. folder containing the Maven POM).

# Check for arguments if we have some.
# If so then process them ...

MAVEN_ARGS="clean install test site"

if [ ! "a${*}" = "a" ]
then
	while [ ! "a${1}" = "a" ]
	do
		if [ "${1}" = "-maven-args" ]
		then
			shift

			if [ "a${1}" = "a" ]
			then
				echo "[ERR] -maven-args requires a supplemental argument (e.g. -maven-args \"clean install\")"

				exit 1
			fi

			MAVEN_ARGS="${1}"
		fi

		shift
	done
fi

. scripts/royalmailutils.sh

APP_ID="uk.co.royalmail.traffic.qa" 
APP_SRC="src//test//java//com//bjss//traffic//resource/app-qa.apk" 
CSV_PATH="src//test//resources" 
WEBSPHERE_LIB_ROOT="${ROYALMAIL_PROJECT_FOLDER_WINDOWS}\\src\\test\\resources\\websphere\\IBM-MQ-JAR" 
SELENDROID_LIB_ROOT="${ROYALMAIL_PROJECT_FOLDER_WINDOWS}\\src\\test\\java\\com\\bjss\\traffic\\libs" 
CUCUMBER_OPTIONS="src/test/java/com/bjss/traffic/features/ --tags @sprint1"

mvn ${MAVEN_ARGS} -DappId="${APP_ID}" -DappSrc="${APP_SRC}" -Dcsvpath="${CSV_PATH}" -DmqLibDir="${WEBSPHERE_LIB_ROOT}" -Dselendroid="${SELENDROID_LIB_ROOT}" -Dcucumber.options="${CUCUMBER_OPTIONS}"
