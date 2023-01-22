using Amazon.CDK.AWS.DynamoDB;
using Amazon.CDK;
using Constructs;
using Attribute = Amazon.CDK.AWS.DynamoDB.Attribute;

namespace CloudInfrastructure.CRUD
{
    public class StorageConstruct : Construct
    {
        public readonly Table tableCrud;
        
        public StorageConstruct(Construct scope, string id, IConstructProps props = null) : base(scope, id)
        {
            tableCrud = new Table(this, Utils.prefixed("Table"), new TableProps()
            {
                TableName = Utils.prefixed("Table"),
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
                Stream = StreamViewType.NEW_AND_OLD_IMAGES,
            });
        }
    }

    public interface IConstructProps
    {
    }

}

