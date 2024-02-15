using System;
using System.Collections.Generic;
using System.Text;

namespace сети_лаб2
{
    class Addr
    {
        int ishod;
        int nazn;

        public int Ishod
        {
            set { ishod = value; }
            get { return ishod; }
        }
        public int Nazn
        {
            set { nazn = value; }
            get { return nazn; }
        }        
        public Addr()
        {
            ishod = 0;
            nazn = 0;
        }
        public void SetVal(int nom)
        {
            if (ishod == 0) ishod = nom;
            else
                if (nazn == 0)
                {
                    nazn = nom;
                    //вычисл маршрута
                }            
        }
        public void Clear()
        {
            ishod = 0;
            nazn = 0;
        }
    }
}
