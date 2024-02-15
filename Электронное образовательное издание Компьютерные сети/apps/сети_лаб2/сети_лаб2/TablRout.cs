using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace сети_лаб2
{
    public class TablRout : IEnumerable
    {
        private ArrayList Tabl;
        public TablRout() { Tabl = new ArrayList(); }
        public void AddRout(LineTabl val)
        {
            Tabl.Add(val);
        }
        public void DelRout(int num)
        {
            Tabl.RemoveAt(num);
        }
        public int countRout
        {
            get { return Tabl.Count; }
        }
        public void ClearAllRout() { Tabl.Clear(); }
        public bool RoutIsPresent(LineTabl val)
        {
            return Tabl.Contains(val);
        }
        public IEnumerator GetEnumerator() { return Tabl.GetEnumerator(); }
    }
    
}
