using Amazon.CDK;
using Constructs;
using System;
using Amazon.CDK.AWS.Lambda;
using Amazon.CDK.AWS.DynamoDB;
using Attribute = Amazon.CDK.AWS.DynamoDB.Attribute;
using Amazon.CDK.AWS.APIGateway;
using System.Collections.Generic;

namespace CloudInfrastructure
{
    public class CloudInfrastructureStack : Stack
    {
        Func<string, string> prefixed = (string name) => $"AchieverApp{name}";

        internal CloudInfrastructureStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            var databaseTable = new Table(this, prefixed("Table"), new TableProps()
            {
                TableName = prefixed("Table"),
                PartitionKey = new Attribute()
                {
                    Name = "PK",
                    Type = AttributeType.STRING
                },
                SortKey = new Attribute()
                {
                    Name = "SK",
                    Type = AttributeType.STRING
                },
                BillingMode = BillingMode.PAY_PER_REQUEST,
                RemovalPolicy = RemovalPolicy.DESTROY,
                Encryption = TableEncryption.DEFAULT,
                Stream = StreamViewType.NEW_AND_OLD_IMAGES
            });

            

            var apiGateway = new RestApi(this, prefixed("Api"), new RestApiProps()
            {
                RestApiName = prefixed("Api"),
                Description = "This is the API Gateway for the Achiever App",
                EndpointTypes = new[] { EndpointType.REGIONAL },
                DefaultCorsPreflightOptions = new CorsOptions()
                {
                    AllowOrigins = Cors.ALL_ORIGINS,
                    AllowMethods = Cors.ALL_METHODS,
                    AllowHeaders = Cors.DEFAULT_HEADERS
                }
            });

            
            Function function = new Function(this, prefixed("dbCrud"), new FunctionProps()
            {
                Runtime = Runtime.DOTNET_6,
                Code = Code.FromAsset("assets/AchieverCrud.zip"),
                Handler = "AchieverCrud::AchieverAppLambda.Function::FunctionHandler",
                Environment = new Dictionary<string, string>()
                {
                    { "TABLE_NAME", databaseTable.TableName }
                }
            });

            var crudFnIntegration = new LambdaIntegration(function, new LambdaIntegrationOptions()
            {
                Proxy = true,
                RequestTemplates = new Dictionary<string, string>()
                {
                    { "application/json", "{ \"statusCode\": \"200\" }" }
                }
            });

            databaseTable.GrantReadWriteData(function);

            var rootResource = apiGateway.Root.AddResource("achiever");
            List<string> routePaths = new List<string>() { "achievements", "quests", "characters" };
            routePaths.ForEach(routePath =>
            {
                var routePathResource = rootResource.AddResource(routePath);
                var commonOptions = new MethodOptions()
                {
                    AuthorizationType = AuthorizationType.NONE,
                    MethodResponses = new[] { 
                        new MethodResponse() { StatusCode = "200" },
                        new MethodResponse() { StatusCode = "201" },
                        new MethodResponse() { StatusCode = "202" },
                        new MethodResponse() { StatusCode = "400",},
                        new MethodResponse() { StatusCode = "401",},
                        new MethodResponse() { StatusCode = "403",},
                        new MethodResponse() { StatusCode = "404",},
                        new MethodResponse() { StatusCode = "500",},
                        new MethodResponse() { StatusCode = "503",},
                    },
                };

                // List all items
                routePathResource.AddMethod("GET", crudFnIntegration, commonOptions);

                var getByIdResource = routePathResource.AddResource("{id}");
                
                // Get item by id
                getByIdResource.AddMethod("GET", crudFnIntegration, commonOptions);

                // Create new item
                routePathResource.AddMethod("POST", crudFnIntegration, commonOptions);

                // Update item by id
                getByIdResource.AddMethod("PUT", crudFnIntegration, commonOptions);   

                // Delete item by id
                getByIdResource.AddMethod("DELETE", crudFnIntegration, commonOptions);
            });
        }
    }
}
