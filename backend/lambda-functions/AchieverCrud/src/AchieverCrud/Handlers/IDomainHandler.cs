using AchieverCrud.Domain.Models;
using AchieverCrud.Domain.Services;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.Lambda.Core;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AchieverCrud.Handlers
{
    public interface IDomainHandler<T> 
    {
        Task<APIGatewayProxyResponse> Handle(APIGatewayProxyRequest request, ILambdaContext context);
    }

    public class DomainHandler<T> : IDomainHandler<T> where T: Model<T>
    {
        readonly IDomainService<T> _service;

        public DomainHandler(IDomainService<T> service)
        {
            _service = service;
        }

        public Task<APIGatewayProxyResponse> Handle(APIGatewayProxyRequest request, ILambdaContext context)
        {
            switch (request.HttpMethod)
            {
                case "GET":
                    return HandleGetRequest(request, context);
                case "POST":
                    return HandlePostRequest(request, context);
                case "PUT":
                    return HandlePutRequest(request, context);
                case "DELETE":
                    return HandleDeleteRequest(request, context);
                default:
                    return Task.FromResult(new APIGatewayProxyResponse
                    {
                        StatusCode = 405,
                        Body = "Method not allowed"
                    });
            }
        }

        private async Task<APIGatewayProxyResponse> HandleDeleteRequest(APIGatewayProxyRequest request, ILambdaContext context)
        {
            try
            {
                var id = request.PathParameters["id"];
                await _service.Delete(id);
                return new APIGatewayProxyResponse
                {
                    StatusCode = 200,
                    Body = "Item deleted."
                };
            }
            catch (Exception e)
            {
                context.Logger.LogError($"Error deleting: {e.Message}{e.StackTrace}");
                return new APIGatewayProxyResponse
                {
                    StatusCode = 500,
                    Body = "An error occurred."
                };
            }
        }

        private async Task<APIGatewayProxyResponse> HandlePutRequest(APIGatewayProxyRequest request, ILambdaContext context)
        {
            try
            {
                await _service.Update(request.Body);
                return new APIGatewayProxyResponse
                {
                    StatusCode = 200,
                    Body = "Item updated."
                };
            }
            catch (Exception e)
            {
                context.Logger.LogError($"Error updating: {e.Message}");
                return new APIGatewayProxyResponse
                {
                    StatusCode = 500,
                    Body = "An error occurred."
                };
            }
        }

        private async Task<APIGatewayProxyResponse> HandlePostRequest(APIGatewayProxyRequest request, ILambdaContext context)
        {
            try
            {
                await _service.Create(request.Body);
                return new APIGatewayProxyResponse
                {
                    StatusCode = 200,
                    Body = $"{typeof(T).Name} created."
                };
            }
            catch (Exception e)
            {
                context.Logger.LogError($"Error creating : {e.Message}");
                return new APIGatewayProxyResponse
                {
                    StatusCode = 500,
                    Body = "An error occurred."
                };
            }
        }

        private async Task<APIGatewayProxyResponse> HandleGetRequest(APIGatewayProxyRequest request, ILambdaContext context)
        {

                var id = request.PathParameters["id"];
                try
                {
                    if (request.Path.EndsWith("/details"))
                    {
                        List<T> res = await _service.GetSingleWithDetails(id);
                        return new APIGatewayProxyResponse
                        {
                            StatusCode = 200,
                            Body = JsonConvert.SerializeObject(res)
                        };
                    }
                    else
                    {
                        T res = await _service.GetSingle(id);
                        return new APIGatewayProxyResponse
                        {
                            StatusCode = 200,
                            Body = JsonConvert.SerializeObject(res)
                        };
                    }
                }
                catch (Exception e)
                {
                    context.Logger.LogError($"Error getting single: {e.Message}{e.StackTrace}");
                    return new APIGatewayProxyResponse
                    {
                        StatusCode = 500,
                        Body = "An error occurred."
                    };
                }
            
            //return RequestedRouteNotFound(request);
        }
    }
}
