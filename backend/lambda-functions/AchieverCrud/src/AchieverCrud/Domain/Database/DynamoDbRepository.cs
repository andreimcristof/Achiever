using Amazon.DynamoDBv2.DataModel;
using AchieverCrud.Domain.Models;
using Amazon.DynamoDBv2;

namespace AchieverCrud.Domain.Database
{
    /// <summary>
    /// DynamoDB wrapper using Object Persistence Model (aws's DataModel).
    /// For details, see <see href="https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/dynamodb-intro.html">official docs here</see>.
    /// </summary>
    internal class DynamoDbRepository<T> : IDisposable, IRepository<T> where T : DynamoDbModel<T>
    {
        private DynamoDBContext context;
        /// <summary>
        /// Due to a bug in the DynamoDBContext where we cannot use a dynamic table name assigned at runtime, for DataModel object persistence in DynamoDB, 
        /// we need to override the table on each operation (see members), so 
        /// we need to store the table name for that. <see href="https://github.com/aws/aws-sdk-net/issues/1421"/>
        /// </summary>
        private DynamoDBOperationConfig customDbOperationConfig;

        public DynamoDbRepository(string tableName)
        {
            this.customDbOperationConfig = new DynamoDBOperationConfig { OverrideTableName = tableName };
            context = new DynamoDBContext(new AmazonDynamoDBClient());
        }

        public async Task<T> GetSingle(string id) => await context.LoadAsync<T>(id, typeof(T).Name, customDbOperationConfig);

        public async Task<List<T>> GetGroupedInfo(string id) => await context.QueryAsync<T>(id, customDbOperationConfig).GetRemainingAsync();
        
        public async Task<List<T>> GetAll() => await context.ScanAsync<T>(new List<ScanCondition>(), customDbOperationConfig).GetRemainingAsync();

        public async Task Create(T item) => await context.SaveAsync(item, customDbOperationConfig);
        
        public async Task<T> Update(T item)
        {
            await context.SaveAsync(item, customDbOperationConfig);
            return item;
        }

        public async Task Delete(string id)
        {
            var item = await context.LoadAsync<T>(id);
            await context.DeleteAsync(item, customDbOperationConfig);
        }

        public void Dispose()
        {
            context.Dispose();

        }
    }
}