#!/bin/sh


#read parameters
workspace=$1
profile=$2
env_condition=$3
build_tag=$4
jeksin_home=$5
version=$6


buildPlist="$workspace/funlive/Info.plist"
version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $buildPlist)



printf $workspace
printf $profile
printf $env_condition
printf $build_tag
printf $jeksin_home
printf $version

#get build time
buildDay=$(date +%Y%m%d)
buildTime=$(date +%Y%m%d%H%M)

if [ -n "$version" ]; then
	middleName=${version}_${buildTime}
else
	middleName=${buildTime}
fi

#setup path
if [ "$env_condition" = "Test" ]; then
	ipaSympolName="AutoBuilder_QA_${middleName}.xcarchive"
	buildPath="$workspace/${buildDay}/$ipaSympolName"
	ipaName="AutoBuilder_QA_${middleName}.ipa"
	ipaPath="$workspace/${buildDay}/$ipaName"
	descName="AutoBuilder_QA_${middleName}.txt"
	plistName="AutoBuilder_QA_${middleName}.plist"
	ipaCommonName="AutoBuilder_QA_${version}"
	ipaCommonPath="$workspace/${buildDay}/${ipaCommonName}.ipa"

	nameWithoutPosufix="AutoBuilder_QA_${middleName}"

	testPorvisionName=""
	testIpaPath=""
	ipaTestProvisionCommonName=""
	ipaTestProvisionCommonPath=""


elif [ "$env_condition" = "Rtc" ]; then
	ipaSympolName="AutoBuilder_Beta_${middleName}.xcarchive"
	buildPath="$workspace/${buildDay}/$ipaSympolName"
	ipaName="AutoBuilder_Beta_${middleName}.ipa"
	ipaPath="$workspace/${buildDay}/$ipaName"
	descName="AutoBuilder_Beta_${middleName}.txt"
	plistName="AutoBuilder_Beta_${middleName}.plist"
	ipaCommonName="AutoBuilder_Beta_${version}"
	ipaCommonPath="$workspace/${buildDay}/${ipaCommonName}.ipa"
	nameWithoutPosufix="AutoBuilder_Beta_${middleName}"

	testPorvisionName=""
	testIpaPath=""
	ipaTestProvisionCommonName=""
	ipaTestProvisionCommonPath=""


else
	ipaSympolName="AutoBuilder_Release_${middleName}.xcarchive"
	buildPath="$workspace/${buildDay}/$ipaSympolName"
	ipaName="AutoBuilder_Release_${middleName}.ipa"
	ipaPath="$workspace/${buildDay}/$ipaName"
	descName="AutoBuilder_Release_${middleName}.txt"
	plistName="AutoBuilder_Release_${middleName}.plist"
	ipaCommonName="AutoBuilder_Release_${version}"
	ipaCommonPath="$workspace/${buildDay}/${ipaCommonName}.ipa"
	nameWithoutPosufix="AutoBuilder_Release_${middleName}"

	testPorvisionName="AutoBuilder_Release_${middleName}_TestProvision.ipa"
	testIpaPath="$workspace/${buildDay}/$testPorvisionName"
	ipaTestProvisionCommonName="AutoBuilder_Release_${version}_TestProvision"
	ipaTestProvisionCommonPath="$workspace/${buildDay}/${ipaTestProvisionCommonName}.ipa"


	
fi

if [ "$profile" = "Distrubution" ]; then
	sed -i -e "s/PROVISIONING_PROFILE = .*;/PROVISIONING_PROFILE = \"1335904a-d7a7-430c-b868-801c80e9db07\";/g" $workspace/funlive.xcodeproj/project.pbxproj
	sed -i -e "s/PROVISIONING_PROFILE_SPECIFIER = .*;/PROVISIONING_PROFILE_SPECIFIER = tv.ihuoxing.distribution;/g" $workspace/funlive.xcodeproj/project.pbxproj
else
	sed -i -e "s/PROVISIONING_PROFILE = .*;/PROVISIONING_PROFILE = \"574f3d05-d3cb-42c1-bdd4-627c231ef59f\";/g" $workspace/funlive.xcodeproj/project.pbxproj
	sed -i -e "s/PROVISIONING_PROFILE_SPECIFIER = .*;/PROVISIONING_PROFILE_SPECIFIER = 0607_wuli_dev;/g" $workspace/funlive.xcodeproj/project.pbxproj
fi



sed -i -e "s/ProvisioningStyle = Automatic/ProvisioningStyle = Manual/g" ${workspace}/funlive.xcodeproj/project.pbxproj

sed -i -e "/DEVELOPMENT_TEAM/d" $workspace/funlive.xcodeproj/project.pbxproj


#change the config files
if [ "$env_condition" = "Test" ]; then
	sed -i -e "s/\/\/#define kFunLiveDevelopment/#define kFunLiveDevelopment/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/#define kFunLivePreDistribution/\/\/#define kFunLivePreDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/#define kFunLiveDistribution/\/\/#define kFunLiveDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	category="qa"
elif [ "$env_condition" = "Rtc" ]; then
	sed -i -e "s/#define kFunLiveDevelopment/\/\/#define kFunLiveDevelopment/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/\/\/#define kFunLivePreDistribution/#define kFunLivePreDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/#define kFunLiveDistribution/\/\/#define kFunLiveDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	category="beta"
else
	sed -i -e "s/#define kFunLiveDevelopment/\/\/#define kFunLiveDevelopment/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/#define kFunLivePreDistribution/\/\/#define kFunLivePreDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	sed -i -e "s/\/\/#define kFunLiveDistribution/#define kFunLiveDistribution/g" $workspace/funlive/Vendor/FLNet/FLNetWorking/HttpConfig.h
	category="release"
fi



#change info.plist
buildPlist="$workspace/funlive/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version" "$buildPlist"

if [ "$profile" = "Distrubution" ]; then
	# /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier xxxxxxxxx" "$buildPlist"

	codeSign="iPhone Distribution: Khorgas Wuli network technology co., LTD (Z55W3773DC)"
    provisionProfile="1335904a-d7a7-430c-b868-801c80e9db07"
    exportProfile="tv.ihuoxing.distribution"

else
	# /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier xxxxxxxx" "$buildPlist"

	codeSign="iPhone Developer: jiangang wang (ZAP4Y9VW23)"
    provisionProfile="574f3d05-d3cb-42c1-bdd4-627c231ef59f"
    exportProfile="0607_wuli_dev"
fi

#sleep in order to 
sleep 2

#do build command

xcodebuild -workspace $workspace/funlive.xcworkspace -scheme funlive clean CODE_SIGN_IDENTITY="${codeSign}" PROVISIONING_PROFILE="${provisionProfile}"

xcodebuild -workspace $workspace/funlive.xcworkspace -scheme funlive archive -archivePath ${buildPath} CODE_SIGN_IDENTITY="${codeSign}" PROVISIONING_PROFILE="${provisionProfile}"

xcodebuild -exportArchive -exportFormat IPA -archivePath ${buildPath} -exportPath ${ipaPath} -exportProvisioningProfile "$exportProfile"


if [ "$profile" = "Distrubution" ]; then
	exportProfile="0607_wuli_dev"

	if [ "$testIpaPath" != "" ]; then
		xcodebuild -exportArchive -exportFormat IPA -archivePath ${buildPath} -exportPath ${testIpaPath} -exportProvisioningProfile "$exportProfile"		
	fi
	
fi

if [ $? -eq 0 ];then
	rm -rf $workspace/funlive/Info.plist


#create air install plist

	appName="要播"
	bundleIdentifier="tv.ihuoxing"
	bundleVersion=$version
	url="http://36.110.113.131:8534/mobidown/"${ipaCommonName}".plist"

	cat << EOF > $workspace/script/build/${ipaCommonName}".plist"	
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
          			<string>$url</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
        		<string>$bundleIdentifier</string>
                <key>bundle-version</key>
                <string>$bundleVersion</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>$appName</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF

	url="http://36.110.113.131:8534/mobidown/history/"$ipaName
	cat << EOF > $workspace/script/build/$plistName
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
          			<string>$url</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
        		<string>$bundleIdentifier</string>
                <key>bundle-version</key>
                <string>$bundleVersion</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>$appName</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF




	chmod +x $workspace/script/build/uploadiPa.sh

	$workspace/script/build/uploadiPa.sh $workspace/script/build/$plistName ${category}/"history"
	$workspace/script/build/uploadiPa.sh $workspace/script/build/${ipaCommonName}".plist" ${category}
	rm -rf $workspace/script/build/$plistName
	rm -rf $workspace/script/build/${ipaCommonName}.plist


	$workspace/script/build/uploadiPa.sh ${ipaPath} ${category}/"history"
	cp ${ipaPath} ${ipaCommonPath}
	$workspace/script/build/uploadiPa.sh ${ipaCommonPath} ${category}
	rm -rf ${ipaPath}
	rm -rf ${ipaCommonPath}


	if [ "$testIpaPath" != "" ]; then
		$workspace/script/build/uploadiPa.sh ${testIpaPath} ${category}/"history"
		cp ${testIpaPath} ${ipaTestProvisionCommonPath}
		$workspace/script/build/uploadiPa.sh ${ipaTestProvisionCommonPath} ${category}

		rm -rf ${testIpaPath}
		rm -rf ${ipaTestProvisionCommonPath}
	fi

	


	
	cd ${buildPath}
	cd ..
	tar -cvf $nameWithoutPosufix.tar $ipaSympolName
	$workspace/script/build/uploadiPa.sh $nameWithoutPosufix.tar ${category}/"history"

	rm -rf $nameWithoutPosufix.tar
	rm -rf $ipaSympolName


	cp $workspace/script/build/buildInfo.desc $workspace/script/build/${ipaCommonName}".txt"
	$workspace/script/build/uploadiPa.sh $workspace/script/build/${ipaCommonName}".txt" ${category}
	rm -rf $workspace/script/build/${ipaCommonName}".txt"

	cp $workspace/script/build/buildInfo.desc $workspace/script/build/$descName
	$workspace/script/build/uploadiPa.sh $workspace/script/build/$descName ${category}/"history"
	rm -rf $workspace/script/build/$descName

	changeContentPath=$jeksin_home"/email-templates/"
	mv -i  $workspace/script/build/buildInfo.desc $changeContentPath"/"${build_tag}".change"
	
	if [ "$testIpaPath" != "" ]; then
		echo "http://36.110.113.131:8534/data/HiFun_IOS/"${category}"/history/"$testPorvisionName >${JENKINS_HOME}/email-templates/${build_tag}".test"
	fi
	
	echo "http://36.110.113.131:8534/data/HiFun_IOS/"${category}"/history/"$ipaName >${JENKINS_HOME}/email-templates/${build_tag}
	echo "http://36.110.113.131:8534/data/HiFun_IOS/"${category}"/history/"$nameWithoutPosufix".tar" >${JENKINS_HOME}/email-templates/${build_tag}".achieve"

else
	exit 1
fi
