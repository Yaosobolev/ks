using System;
using System.Collections.Generic;
using System.Text;

namespace сети_лаб2
{
    public class Router
    {
        public int nRout;
        public int nPort;

        public Router(int n1,int n2)
        {
            nRout = n1;
            nPort = n2;
        }
        public Router()
        {
            nRout = 0;
            nPort = 0;
        }
    }

}
