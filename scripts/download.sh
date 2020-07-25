#!/bin/bash

# This script is meant to be used with the command 'datalad run'

for i in "$@"
do
	case ${i} in
		--curl_options=*)
		CURL_OPTIONS="${i#*=}"
		echo "CURL_OPTIONS = [${CURL_OPTIONS}]"
		;;
		-h | --help | *)
		>&2 echo "Unknown option [${i}]. Valid options are:"
		>&2 echo "--curl_options=CURL_OPTIONS"
		exit 1
		;;
	esac
done

# This url requires login cookies to download the file
for file_url in "https://catalog.ldc.upenn.edu/download/8cf0056fed9788cb2fddf92830aef490ad9588c344f512add49221a9c578 ontonotes-release-5.0_LDC2013T19.tgz"
do
	echo ${file_url} | git-annex addurl -c annex.largefiles=anything --raw --batch --with-files \
		-c annex.security.allowed-ip-addresses=all -c annex.web-options="${CURL_OPTIONS}"
done
