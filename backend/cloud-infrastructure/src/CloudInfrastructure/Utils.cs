using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CloudInfrastructure
{
    public  class Utils
    {
        public static Func<string, string> prefixed = (string name) => $"AchieverApp{name}";
    }
}
