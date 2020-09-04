#!/bin/bash
# change the separator to the new line (instead of space) since we use spaces in our path
IFS=$'\n'

# the fodler where the script is (and ffmpeg)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# ffmpeg exe
ffmpeg="/E/tools/ffmpeg-20200831-4a11a6f-win64-static/bin/ffmpeg.exe"

# where our files are stored
rootdir="/C/Users/nadez/Dropbox/Online Business/Existing Websites/Unicorn/Images/Air Omni/"
# where we will put converted files
movdir="mov/"
rootdirmov=$rootdir$movdir

cd $rootdir

##### list all the dirs (and only dirs)
# use this precise syntax - it is VERY important!!!
inputdirs=("$(ls */ -d)")
# debug - check if you see all your folders
#echo "inputdirs:"
#echo "$inputdirs"
echo

inputfile="behind the scene P7254399"
inputext=".avi"

for inputdir in $inputdirs;do
	fullinputdir=$rootdir$inputdir
	cd $fullinputdir
	#list all AVIs in the folder
	avis=("$(find -iname "*.AVI" -or -iname "*.avi")")
	#list all JPGs in the folder
	jpgs=("$(find -iname "*.JPG" -or -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.JPEG")")
	
	# we skip "mov" folder
	# if test 
	
	# add WAV file
	
	# we skip all folders that do not have AVI of JPG files
	if test -z "$avis";then
		if test -z "$jpgs";then
			continue
		fi
	fi
	
	echo "We are in the dir => $inputdir"
	
	echo "AVI files:"
	echo "$avis"

	# make a new MOV dir
	outputdir=$rootdir$movdir$inputdir
	echo "we create a dir $outputdir"
	mkdir -p $outputdir
	
	# convert AVIs to MOVs
	for file in $avis;do
		# remove extension
		filename="${file%.*}"
		# remove the path
		filename=`basename $filename`
		
		# echo "file = $file"
		# echo "filename w/o path and ext = $filename"
		
		$ffmpeg -i $file -acodec copy -vcodec copy -f mov $outputdir$filename".mov"
		
	done
		
	# copy JPGs to the new folder
	for file in $jpgs;do
		# echo "file to copy = $file"
		cp -f "$file" "$outputdir"
	done
	
	#break
	
	echo
	echo
	echo
done


cd $DIR


#does not convert 🤷‍
#bin/ffmpeg.exe -i "/C/Users/nadez/Dropbox/Online Business/Existing Websites/Unicorn/Images/Air Omni/0 - behind the scene/behind the scene P7254399.avi" -acodec libmp3lame -ab 192 "converted.mov"
