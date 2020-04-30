import * as cdk from '@aws-cdk/core';
import ssm = require('@aws-cdk/aws-ssm');
import sqs = require('@aws-cdk/aws-sqs');

export class SsmTestStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const ssmPath = this.node.tryGetContext('ssmPath')

    if(!ssmPath) throw new Error("missing ssmPath")

    const paramValue = ssm.StringParameter.valueForStringParameter(this, ssmPath)

    const paramAttribute = ssm.StringParameter.fromStringParameterAttributes(this, 'bstest-name', {
      parameterName: ssmPath,
      simpleName: false,
    } as ssm.StringParameterAttributes);

    // using a queue to test as tagging the stack directly seems to fail. 
    const queue = new sqs.Queue(this, 'test')

    cdk.Tag.add(queue, 'ssmByValue', paramValue)
    cdk.Tag.add(queue, 'ssmByAttribute', paramAttribute.stringValue)

    new cdk.CfnOutput(this, 'OutputByValue', {value: paramValue})
    new cdk.CfnOutput(this, 'OutputByAttribute', {value: paramAttribute.stringValue})

  }
}
