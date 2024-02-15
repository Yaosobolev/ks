using System;
using System.Collections.Generic;
using System.Text;

namespace сети_лаб2
{
    public class LineTabl
    {
        public int addrPurp;
        public Router nextRout = new Router();
        public Router outRout = new Router();
        public int hop;

        public LineTabl(int n1, Router n2, Router n3, int kol)
        {
            addrPurp = n1;
            nextRout = n2;
            outRout = n3;
            hop = kol;
        }
    }
}
