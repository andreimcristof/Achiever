using Xunit;
using Amazon.Lambda.Core;
using Amazon.Lambda.TestUtilities;

namespace AchieverCrud.Tests;

public class FunctionTest
{
    [Fact]
    public void TestToUpperFunction()
    {

        // Invoke the lambda function and confirm the string was upper cased.
        var function = new Function();
        var context = new TestLambdaContext();
        var upperCase = function.FunctionHandler(new Amazon.Lambda.APIGatewayEvents.APIGatewayProxyRequest(), context);

        // TODO: finish testing 
        Assert.Equal(String.Empty, String.Empty);
    }
}
