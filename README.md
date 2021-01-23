This script install node js 14 along with react, babel, webpack and jest. It includes the associated config files for these packages and creates a basic project folder structure.

Must be ran as root.

Accepts up to 2 arguments, the first arguement is a file path and the second arguement is to choose to include a buildspec.yml file.

The buildspec.yml file is for AWS Code Pipeline.

If the second arguement is ci the buildspec.yml file will be included.

This script installs node js 14 along with babel, webpack and jest. It includes the associated config files for those packages.

Example usage:
	Runs the script and inclused the buildspec.yml file
	sudo bash ./nodejsdeployment.sh ci

	Runs the script and does not include the buildspec.yml file
	sudo bash ./nodejsdeployment.sh

