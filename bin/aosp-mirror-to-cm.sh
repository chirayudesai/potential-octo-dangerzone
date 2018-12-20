#!/bin/bash

AOSP_MIRROR=~/android/mirror/aosp
CM_MIRROR=~/android/mirror/cm
projects=`find ${AOSP_MIRROR}/platform/ -type d -name "*.git" | sed s#${AOSP_MIRROR}/##g | sed s#platform/#android/#g | sed s#/#_#g`

aosp_project() {
	aosp_project_name=`echo $1 | sed s#android_##g | sed s#_#/#g`
	echo ${AOSP_MIRROR}/platform/${aosp_project_name}.git
}

cm_project() {
	cm_project_name=`echo $1 | sed s#platform/#android/#g | sed s#/#_#g`
	echo ${CM_MIRROR}/CyanogenMod/${cm_project_name}.git
}

pushd ${CM_MIRROR}
for i in $projects; do
	grep -q $i .repo/manifest.xml
	if [ $? -eq 0 ]; then
		if [ ! -d CyanogenMod/$i.git ] ; then
			echo $i
			mkdir -p CyanogenMod/$i.git
			GIT_DIR="CyanogenMod/$i.git" git init --bare
			echo "`aosp_project $i`/objects"> CyanogenMod/$i.git/objects/info/alternates
		fi
	fi
done
popd
