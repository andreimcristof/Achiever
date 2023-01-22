using Amazon.CDK;
using Constructs;
using System;
using System.Collections.Generic;
using CloudInfrastructure.CRUD;
using Amazon.CDK.AWS.AppSync;
namespace CloudInfrastructure
{
    public class CloudInfrastructureStack : Stack
    {
        internal CloudInfrastructureStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            RestfulApiWithCrudEndpoints();
            GraphQlApiWithAppSync();
            RealTimePubSubMessagingWithAppSync();
        }

        private void RealTimePubSubMessagingWithAppSync()
        {
            //throw new NotImplementedException();
        }

        private void RestfulApiWithCrudEndpoints()
        {
            var storage = new StorageConstruct(this, Utils.prefixed("Storage"));
            var restApi = new RestApiGatewayWithLambda(this, Utils.prefixed("RestApiGatewayWithLambda"));

            restApi.fnCrud.AddEnvironment("TABLE_NAME", storage.tableCrud.TableName);
            storage.tableCrud.GrantReadWriteData(restApi.fnCrud);
        }

        private void GraphQlApiWithAppSync()
        {
            var graphqlApi = new GraphqlApi(this, Utils.prefixed("GraphQlApi"), new GraphqlApiProps()
            {
                Name = Utils.prefixed("GraphQlApi"),
                Schema = SchemaFile.FromAsset("assets/schema.graphql"),
                AuthorizationConfig = new AuthorizationConfig()
                {
                    DefaultAuthorization =  new AuthorizationMode()
                    {
                        AuthorizationType = AuthorizationType.API_KEY,
                        ApiKeyConfig = new ApiKeyConfig()
                        {
                            Expires = Expiration.After(Duration.Days(365))
                        }
                    }
                }
            });
        }
    }
}
