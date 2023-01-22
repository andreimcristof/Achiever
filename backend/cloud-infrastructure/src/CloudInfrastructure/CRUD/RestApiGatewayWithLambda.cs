using Amazon.CDK;
using Amazon.CDK.AWS.APIGateway;
using Amazon.CDK.AWS.Lambda;
using Constructs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CloudInfrastructure.CRUD
{
    public class RestApiGatewayWithLambdaProps: IConstructProps
    {
    }
    
    internal class RestApiGatewayWithLambda : Construct
    {
        public readonly RestApi apiGateway;
        public readonly Function fnCrud;

        public RestApiGatewayWithLambda(Construct scope, string id, RestApiGatewayWithLambdaProps props = null) : base(scope, id)
        {
            apiGateway = new RestApi(this, Utils.prefixed("Api"), new RestApiProps()
            {
                RestApiName = Utils.prefixed("Api"),
                Description = "This is the API Gateway for the Achiever App",
                EndpointTypes = new[] { EndpointType.REGIONAL },
                DefaultCorsPreflightOptions = new CorsOptions()
                {
                    AllowOrigins = Cors.ALL_ORIGINS,
                    AllowMethods = Cors.ALL_METHODS,
                    AllowHeaders = Cors.DEFAULT_HEADERS
                }
            });

            fnCrud = new Function(this, Utils.prefixed("dbCrud"), new FunctionProps()
            {
                Runtime = Runtime.DOTNET_6,
                Code = Code.FromAsset("assets/AchieverCrud.zip"),
                Handler = "AchieverCrud::AchieverCrud.Function::FunctionHandler",
                Timeout = Duration.Seconds(60),
            });

            var fnCrudIntegration = new LambdaIntegration(fnCrud, new LambdaIntegrationOptions()
            {
                Proxy = true,
                RequestTemplates = new Dictionary<string, string>()
                {
                    { "application/json", "{ \"statusCode\": \"200\" }" }
                }
            });

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
                routePathResource.AddMethod("GET", fnCrudIntegration, commonOptions);

                var getByIdResource = routePathResource.AddResource("{id}");

                // Get item by id
                getByIdResource.AddMethod("GET", fnCrudIntegration, commonOptions);

                var getByIdWithDetailsResource = getByIdResource.AddResource("details");

                // Get item by id with details
                getByIdWithDetailsResource.AddMethod("GET", fnCrudIntegration, commonOptions);

                // Create new item
                routePathResource.AddMethod("POST", fnCrudIntegration, commonOptions);

                // Update item by id
                getByIdResource.AddMethod("PUT", fnCrudIntegration, commonOptions);

                // Delete item by id
                getByIdResource.AddMethod("DELETE", fnCrudIntegration, commonOptions);
            });

        }
    }
}
