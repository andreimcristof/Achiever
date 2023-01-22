using AchieverCrud.Domain.Database;
using AchieverCrud.Domain.Models;
using AchieverCrud.Domain.Services;
using AchieverCrud.Handlers;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.Lambda.Core;
using Amazon.Runtime.Internal.Util;
using Newtonsoft.Json;
using System.Reflection.Metadata;
using System.Text.Json.Serialization;


// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace AchieverCrud;

public class Function
{
    private string tableName;
    
    public Function()
    {
        tableName = Environment.GetEnvironmentVariable("TABLE_NAME")!;
    }

    
    public async Task<APIGatewayProxyResponse> FunctionHandler(APIGatewayProxyRequest request, ILambdaContext context)
    {
        context.Logger.LogInformation($"AchieverAppCrud called: {request.HttpMethod}: {request.Path}");

        if (request.Path.StartsWith("/achiever/achievements"))
        {
            var service = new DomainService<Achievement>(new DynamoDbRepository<Achievement>(tableName), context.Logger);
            var handler = new DomainHandler<Achievement>(service);
            return await handler.Handle(request, context);
        }
        if (request.Path.StartsWith("/achiever/quests"))
        {
            var service = new DomainService<Quest>(new DynamoDbRepository<Quest>(tableName), context.Logger);
            var handler = new DomainHandler<Quest>(service);
            return await handler.Handle(request, context);
        }
        if (request.Path.StartsWith("/achiever/characters"))
        {
            var service = new DomainService<Character>(new DynamoDbRepository<Character>(tableName), context.Logger);
            var handler = new DomainHandler<Character>(service);
            return await handler.Handle(request, context);
        }
            
        return new APIGatewayProxyResponse
        {
            StatusCode = 404,
            Body = $"No route found for {request.Path}"
        };
    }
}
