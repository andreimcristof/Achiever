using Amazon.DynamoDBv2;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.Lambda.Core;


// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace AchieverCrud;

public class Function
{
    private static class RoutePath
    {
        public const string Achievements = "/achievements";
        public const string Quests = "/quests";
        public const string Characters = "/characters";
    }
    
    /// <summary>
    /// A simple function that takes a string and does a ToUpper
    /// </summary>
    /// <param name="input"></param>
    /// <param name="context"></param>
    /// <returns></returns>```````
    public async Task<APIGatewayHttpApiV2ProxyResponse> FunctionHandler(APIGatewayHttpApiV2ProxyRequest request, ILambdaContext context)
    {
        context.Logger.Log($"AchieverAppCrud Lambda called with: {request}");
        AmazonDynamoDBClient dbClient = new AmazonDynamoDBClient();
        
        var tableName = Environment.GetEnvironmentVariable("TABLE_NAME");        

        switch (request.RawPath)
        {
            case RoutePath.Achievements:
                return await AchievementsHandler(request, context, dbClient, tableName);
            case RoutePath.Quests:
                return await QuestsHandler(request, context, dbClient, tableName);
            case RoutePath.Characters:
                return await CharactersHandler(request, context, dbClient, tableName);

            default:
                return new APIGatewayHttpApiV2ProxyResponse
                {
                    StatusCode = 404,
                    Body = $"No route found for {request.RawPath}"
                };
        }
    }

    private Task<APIGatewayHttpApiV2ProxyResponse> CharactersHandler(APIGatewayHttpApiV2ProxyRequest request, ILambdaContext context, AmazonDynamoDBClient dbClient, string? tableName)
    {
        return Task.FromResult(new APIGatewayHttpApiV2ProxyResponse
        {
            StatusCode = 200,
            Body = $"CharactersHandler called with {request.RawPath}"
        });
    }

    private Task<APIGatewayHttpApiV2ProxyResponse> QuestsHandler(APIGatewayHttpApiV2ProxyRequest request, ILambdaContext context, AmazonDynamoDBClient dbClient, string? tableName)
    {
        return Task.FromResult(new APIGatewayHttpApiV2ProxyResponse
        {
            StatusCode = 200,
            Body = $"QuestsHandler called with {request.RawPath}"
        });
    }

    private Task<APIGatewayHttpApiV2ProxyResponse> AchievementsHandler(APIGatewayHttpApiV2ProxyRequest request, ILambdaContext context, AmazonDynamoDBClient dbClient, string? tableName)
    {
        return Task.FromResult(new APIGatewayHttpApiV2ProxyResponse
        {
            StatusCode = 200,
            Body = $"AchievementsHandler called with {request.RawPath}"
        });
    }
}
