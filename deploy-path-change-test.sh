#!/usr/bin/env bash 

SSM_PATH_1=/testingssm/name1
SSM_PATH_2=/testingssm/name2

aws ssm put-parameter --name $SSM_PATH_1 --value one --type String --overwrite
aws ssm put-parameter --name $SSM_PATH_2 --value two --type String --overwrite

npm run build

npx cdk deploy -c ssmPath=$SSM_PATH_1
echo "name should both end with 'one'"

npx cdk deploy -c ssmPath=$SSM_PATH_2
echo "name should both end with 'two'"
