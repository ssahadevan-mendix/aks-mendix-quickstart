#!/bin/bash

currentDate=`date +%m%d%y`
echo $currentDate

# Got to parent Directory
cd ..
currentDir=aks-mendix-quickstart-main

saveDir=$currentDir-$currentDate
mv $currentDir $saveDir

#Download latest
wget https://github.com/ssahadevan-mendix/aks-mendix-quickstart/archive/main.zip

unzip main.zip

cd $currentDir
mkdir save
cp * save

cp ../$saveDir/env.sh .
cp ../$saveDir/terraform.tfvars .

diff env.sh save
diff terraform.tfvars save

#cleanup
rm ../main.zip

