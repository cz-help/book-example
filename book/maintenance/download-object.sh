#!/bin/sh

base_location="$(dirname $0)"
base_path="${base_location}/../book-chapter-"
sub_path_prefix="container-book-"
sub_path_sufix="_files"
[ "${1}" == "" ] && local_prefix="" || local_prefix="${1}/"

function checkCmd {
	[ $(which curl | wc -l) -gt 0 ] && getCmd="curl"
	[ "${getCmd}" == "" -a $(which wget | wc -l) -gt 0 ] && getCmd="wget"
	if [ "${getCmd}" == "" ]
	then
		echo "Cannot determine command to get the file..."
		exit 1
	fi
}

function getFile {
	[ "${getCmd}" == "" ] && checkCmd
	local_path="$(pwd)"
	[ ! -e ${1} ] && mkdir -p ${1}
	cd ${1}
	shift
	case ${getCmd} in
		curl)
			while [ "${1}" != "" ]
			do
				curl -s -O ${1}
				shift
			done	
			;;
		wget)
			while [ "${1}" != "" ]
			do
				wget -q ${1}
				shift
			done
			;;
	esac
	cd ${local_path}
}

function checkFolderTree {
	[ "${1}" == "" -o "${2}" == "" -o "${1:0:${#2}}" != "${2}" ] && return
	checkPath="$(dirname ${1})"
	while [ "${checkPath}" != "${2}" ]
	do
		if [ $(find ${checkPath} -mindepth 1 | wc -l) -eq 0 ]
		then
			echo " . . . removing : ${checkPath}"
			rmdir ${checkPath}
			checkPath=$(dirname ${checkPath})
		else
			return
		fi
	done
}

function cleanFile {
	while read line
	do
		[ "${line}" == "" ] && echo && continue
		localItem=( ${line} )
		[ "${localItem[0]:0:1}" == "#" ] && continue
		[ "${1}" != "" -a "${1}" != "${localItem[0]}" ] && continue
		if [ -e ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]}) ]
		then
			echo "${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]})"
			rm ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]})
			checkFolderTree ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]}) ${base_path}${localItem[0]}
		else
			echo "SKIP: ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]})"
		fi
	done < ${base_location}/fileList.txt
}

function chapterFile {
	while read line
	do
		[ "${line}" == "" ] && echo && continue
		localItem=( ${line} )
		[ "${localItem[0]:0:1}" == "#" ] && continue
		[ "${1}" != "" -a "${1}" != "${localItem[0]}" ] && continue
		if [ ! -e ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]}) ]
		then
			echo "${localItem[3]} => ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}"
			getFile ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]} ${localItem[3]}
		else
			echo "SKIP: ${base_path}${localItem[0]}/${sub_path_prefix}${localItem[1]}${sub_path_sufix}/${localItem[2]}/$(basename ${localItem[3]})"
		fi
	done < ${base_location}/fileList.txt
}

while [ "${1:0:1}" == "-" ]
do
	case ${1:1} in
		c)
			if [ "${2}" == "" ]
			then
				cleanFile
			else
				while [ "${2}" != "" ]
				do
					cleanFile ${2}
					shift
				done
			fi
			exit 0
			;;
	esac
	switch
done

if [ "${1}" == "" ]
then
	chapterFile
else
	while [ "${1}" != "" ]
	do
		chapterFile ${1}
		shift
	done
fi
