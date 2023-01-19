# Backend of Achiever App

The backend resides in the AWS cloud and is entirely contained in this repository.

## Folder Structure

- `cloud-infrastructure` - here we declare the backend infrastructure as code, using AWS CDK and C#.
- `documentation` - additional documentation specific to each service.
- `lambda-functions` - the backend uses lambdas written with C#, since the tooling for .NET was the simplest to be able to test lambdas and get things done, quicker than other frameworks - subjective opinion :).

## Backend system design

Further details will follow here, but basically we have two major components of the backend:

- a data storage part where we interact with a `DynamoDB` database through `API Gateway` and `AWS Lambda`
- a (pubsub) messaging system where we send to the client various messages and events that the client subscribed to.

## Deployment

- As I wrote above the backend description is written with C#. Deployment steps:
  1. open Visual Studio, build the projects in the folder `backend\lambda-functions` (right now the sln has one function only)
  2. in the folder `backend\lambda-functions\AchieverCrud\src\AchieverCrud` run the command `dotnet-lambda package` (requires isntallation of [Amazon Lambda Tools](https://github.com/aws/aws-lambda-dotnet) in the CLI). The `dotnet-lambda package` command creates a zip of the lambda which can be deployed to AWS, in the output folder (typically `Release` folder).
  3. manual step, which I will automate at some point: copy the zipped lambda function resulted in the previous step into the folder `backend\cloud-infrastructure\assets`.
  4. run the command `cdk deploy` in the folder `\backend\cloud-infrastructure`
  5. Your infra changes and the new functions are now deployed.

P.S. Its really easy to test the functions with the AWS Mock Tool in Visual Studio.
