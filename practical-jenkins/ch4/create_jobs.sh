#!/bin/bash
# Get the repo list from git.
tmpfile="/tmp/repos.txt"
sudo bash -c "curl  -s https://api.github.com/users/apulijala/repos  > /tmpfile"
count=0
python3 get_repos.py | 
while read repo 
do  
    if [[ "$repo" =~ abacus ]]
    then 
        echo "repo is $repo"
        sed  s/simple-pipeline-practice-jenkinsfile/$repo/ config1.xml > config_$count.xml
        ((count=count+1))
        java -jar cli-2.235.1.jar  -s http://localhost:8080 -auth admin:119de55e2f199250d454bcfb8130422755 create-job abacus < config_$count.xml
    fi
done
