#!/usr/bin/env bash 

SSM_PATH=/testingssm/valueTest1

aws ssm put-parameter --name $SSM_PATH --value first --type String --overwrite

npm run build

npx cdk deploy -c ssmPath=$SSM_PATH
echo "name should both end with 'first'"

aws ssm put-parameter --name $SSM_PATH --value second --type String --overwrite

npx cdk deploy -c ssmPath=$SSM_PATH
echo "name should both end with 'second'"
