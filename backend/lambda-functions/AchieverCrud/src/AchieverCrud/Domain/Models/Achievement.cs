using Amazon.DynamoDBv2.DataModel;

namespace AchieverCrud.Domain.Models
{
    [DynamoDBTable("Achievement")]
    public class Achievement : DynamoDbModel<Achievement>
    {
        public string Name { get; set; }
        public string? Description { get; set; }
    }
}
