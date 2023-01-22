using Amazon.DynamoDBv2.DataModel;
using Newtonsoft.Json;

namespace AchieverCrud.Domain.Models
{
    public abstract class Model<T>
    {
        public Model()
        {
            Id = Guid.NewGuid().ToString();
        }

        virtual public string? Id { get; set; }
        static internal string Serialize(T item) => JsonConvert.SerializeObject(item);

        static internal T? FromJson(string json) => JsonConvert.DeserializeObject<T>(json);
    }

    public class DynamoDbModel<T> : Model<T> 
    {
        [DynamoDBHashKey("PK")]
        public override string? Id { get; set;  }        
        

        [DynamoDBRangeKey("SK")]
        public string? SortKey { get; set; }

        public DynamoDbModel():base()
        {
            SortKey = typeof(T).Name;
        }
    }
}