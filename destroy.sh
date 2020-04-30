#!/usr/bin/env bash 

npm run build

npx cdk destroy -c ssmPath='/nope'

 aws ssm delete-parameter --name='/testingssm/valueTest1'
 aws ssm delete-parameter --name='/testingssm/name1'
 aws ssm delete-parameter --name='/testingssm/name2'
