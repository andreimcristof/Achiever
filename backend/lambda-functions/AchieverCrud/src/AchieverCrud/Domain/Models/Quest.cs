using Amazon.DynamoDBv2.DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AchieverCrud.Domain.Models
{
    [DynamoDBTable("Quest")]
    public class Quest : DynamoDbModel<Quest>
    {
        public string Name { get; set; }
        public string Description { get; set; }
    }
}
