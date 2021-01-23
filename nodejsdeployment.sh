#!/bin/sh
file_path=$1
is_ci_cd=$2
directorynames=( "dist" "src" "test" )
filenames=( ".babelrc" "package.json" "package-lock.json" "webpack.config.js" )


#Checks if script is running a root, termninates the script if it is not
if [ "$(id -u)" -ne 0 ]; then 
	echo "Please run this command as root"
	exit
fi

#checks if the specified file path exists, creates it if it doesn't
if [ ! -d "${file_path}" ]; then
	mkdir "${file_path}" || echo Please check you have entered a valid file path
fi

if [ ! -d "${file_path}"/old ]; then
	mkdir "${file_path}"/old
fi

#checks if there is a buildspec.yml file and moves it to old if there is
if [ -f "${file_path}"/buildspec.yml ]; then
	mv "${file_path}"/buildspec.yml "${file_path}"/old
fi

#Checks if ci was passed as an argument and copies buildspec file if it is
if [ "${2} == ci" ]; then
	cp buildspec.yml "${file_path}"
fi

#loops through array of directories, moves them to old if they exist and then creates them
for directory in "${directorynames[@]}"
do
	if [ -d "${file_path}"/"${directory}" ]; then
		mv "${file_path}"/"${directory}" "${file_path}"/old
	fi
	mkdir "${file_path}"/"${directory}"
done

#loops through array of file names, moves them to old if they exist and then copies them to the file path
for filename in "${filenames[@]}"
do
	if [ -f "${file_path}"/"${filename}" ]; then
		mv "${file_path}"/"${filename}" "${file_path}"/old
	fi
	cp "${filename}" "${file_path}"
done

#grants full permissions to the files and directories copied
chmod -R 777 "${file_path}"

#installs curl and node and runs npm install to install npm packages
apt-get install curl -y
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
npm install -y
