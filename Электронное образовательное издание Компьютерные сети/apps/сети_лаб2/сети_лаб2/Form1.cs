using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Drawing.Design;

namespace сети_лаб2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        
        public int[,] matrix;
        private int[] jobM = new int[6]; //для значений исправности маршрутиз

        private Addr _addr = new Addr();
        private TablRout[] masTabl = new TablRout[6];
        private object[] myVal = new object[4];
        public List<int> marshr = new List<int>();
        private bool tabM;
        private int count;

        private void button1_Click(object sender, EventArgs e)
        {
            tabM = true;
            for (int i = 0; i < 6; i++)
                masTabl[i] = null;
            
            SetTable();

            // Столбец "сеть назначения"
            DataColumn col11 = new DataColumn();
            col11.ReadOnly = true;
            col11.ColumnName = "Сеть назн";
            
            // Столбец "сетев адрес след"
            DataColumn col12 = new DataColumn();
            col12.ReadOnly = true;
            col12.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col13 = new DataColumn();
            col13.ReadOnly = true;
            col13.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col14 = new DataColumn();
            col14.ReadOnly = true;
            col14.ColumnName = "hop";
// Таблица 2
            // Столбец "сеть назначения"
            DataColumn col21 = new DataColumn();
            col21.ReadOnly = true;
            col21.ColumnName = "Сеть назн";

            // Столбец "сетев адрес след"
            DataColumn col22 = new DataColumn();
            col22.ReadOnly = true;
            col22.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col23 = new DataColumn();
            col23.ReadOnly = true;
            col23.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col24 = new DataColumn();
            col24.ReadOnly = true;
            col24.ColumnName = "hop";
      // Таблица 3
            // Столбец "сеть назначения"
            DataColumn col31 = new DataColumn();
            col31.ReadOnly = true;
            col31.ColumnName = "Сеть назн";

            // Столбец "сетев адрес след"
            DataColumn col32 = new DataColumn();
            col32.ReadOnly = true;
            col32.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col33 = new DataColumn();
            col33.ReadOnly = true;
            col33.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col34 = new DataColumn();
            col34.ReadOnly = true;
            col34.ColumnName = "hop";
            // Таблица 4
            // Столбец "сеть назначения"
            DataColumn col41 = new DataColumn();
            col41.ReadOnly = true;
            col41.ColumnName = "Сеть назн";

            // Столбец "сетев адрес след"
            DataColumn col42 = new DataColumn();
            col42.ReadOnly = true;
            col42.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col43 = new DataColumn();
            col43.ReadOnly = true;
            col43.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col44 = new DataColumn();
            col44.ReadOnly = true;
            col44.ColumnName = "hop";
            // Таблица 5
            // Столбец "сеть назначения"
            DataColumn col51 = new DataColumn();
            col51.ReadOnly = true;
            col51.ColumnName = "Сеть назн";

            // Столбец "сетев адрес след"
            DataColumn col52 = new DataColumn();
            col52.ReadOnly = true;
            col52.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col53 = new DataColumn();
            col53.ReadOnly = true;
            col53.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col54 = new DataColumn();
            col54.ReadOnly = true;
            col54.ColumnName = "hop";
            // Таблица 6
            // Столбец "сеть назначения"
            DataColumn col61 = new DataColumn();
            col61.ReadOnly = true;
            col61.ColumnName = "Сеть назн";

            // Столбец "сетев адрес след"
            DataColumn col62 = new DataColumn();
            col62.ReadOnly = true;
            col62.ColumnName = "след";

            // Столбец "сетев адр выход"
            DataColumn col63 = new DataColumn();
            col63.ReadOnly = true;
            col63.ColumnName = "выходн порт";

            // Столбец "расстояние до след"
            DataColumn col64 = new DataColumn();
            col64.ReadOnly = true;
            col64.ColumnName = "hop";

            DataTable MTable1 = new DataTable("MTabl");
            MTable1.Columns.Add(col11);
            MTable1.Columns.Add(col12);
            MTable1.Columns.Add(col13);
            MTable1.Columns.Add(col14);
            DataTable MTable2 = new DataTable("MTab2");
            MTable2.Columns.Add(col21);
            MTable2.Columns.Add(col22);
            MTable2.Columns.Add(col23);
            MTable2.Columns.Add(col24);
            DataTable MTable3 = new DataTable("MTab3");
            MTable3.Columns.Add(col31);
            MTable3.Columns.Add(col32);
            MTable3.Columns.Add(col33);
            MTable3.Columns.Add(col34);
            DataTable MTable4 = new DataTable("MTab4");
            MTable4.Columns.Add(col41);
            MTable4.Columns.Add(col42);
            MTable4.Columns.Add(col43);
            MTable4.Columns.Add(col44);
            DataTable MTable5 = new DataTable("MTab5");
            MTable5.Columns.Add(col51);
            MTable5.Columns.Add(col52);
            MTable5.Columns.Add(col53);
            MTable5.Columns.Add(col54);
            DataTable MTable6 = new DataTable("MTab6");
            MTable6.Columns.Add(col61);
            MTable6.Columns.Add(col62);
            MTable6.Columns.Add(col63);
            MTable6.Columns.Add(col64);

            for (int i = 0; i < 6; i++)
            {
                //MTable.Rows.Clear();
                /*MTable.Columns.Clear();                
                MTable.Columns.Add(col1);
                MTable.Columns.Add(col2);
                MTable.Columns.Add(col3);
                MTable.Columns.Add(col4);*/

                //for(int j=0; j<4; j++) myVal[j] = null;                
                switch (i)
                {
                    case 0: dataGridView1.DataSource = ZapolnTabl(i, MTable1); break;
                    case 1: dataGridView2.DataSource = ZapolnTabl(i, MTable2); break;
                    case 2: dataGridView3.DataSource = ZapolnTabl(i, MTable3); break;
                    case 3: dataGridView4.DataSource = ZapolnTabl(i, MTable4); break;
                    case 4: dataGridView5.DataSource = ZapolnTabl(i, MTable5); break;
                    case 5: dataGridView6.DataSource = ZapolnTabl(i, MTable6); break;
                }
            }
            setWidth(dataGridView1);
            setWidth(dataGridView2);
            setWidth(dataGridView3);
            setWidth(dataGridView4);
            setWidth(dataGridView5);
            setWidth(dataGridView6);           
        }

        private DataTable ZapolnTabl(int i, DataTable MTable)
        {
            DataRow row;
            foreach (LineTabl c in masTabl[i])
            {
                if (c.addrPurp == 0) myVal[0] = "Default";
                else if (c.addrPurp == -1) myVal[0] = "Неисправен";
                else myVal[0] = "S" + c.addrPurp.ToString();
                if (c.nextRout.nRout == 0) myVal[1] = "-";
                else myVal[1] = "M" + c.nextRout.nRout.ToString() + "(" + c.nextRout.nPort.ToString() + ")";
                myVal[2] = "M" + c.outRout.nRout.ToString() + "(" + c.outRout.nPort.ToString() + ")";
                if (c.addrPurp == 0) myVal[3] = "-";
                else myVal[3] = c.hop;
                row = MTable.NewRow();
                row.ItemArray = myVal;
                MTable.Rows.Add(row);
            }
            return MTable;
        }
        private void pictureBox1_Click(object sender, EventArgs e)
        {
            _addr.SetVal(1);
        }

        private void pictureBox25_Click(object sender, EventArgs e)
        {
            _addr.SetVal(2);
        }

        private void pictureBox9_Click(object sender, EventArgs e)
        {
            _addr.SetVal(3);
        }

        private void pictureBox21_Click(object sender, EventArgs e)
        {
            _addr.SetVal(4);
        }

        private void pictureBox13_Click(object sender, EventArgs e)
        {
            _addr.SetVal(5);
        }

        private void pictureBox17_Click(object sender, EventArgs e)
        {
            _addr.SetVal(6);
        }

        private void SetTable()
        {
            //Заполнение табл маршрутиз № 1
            masTabl[0] = new TablRout();
            if (jobM[0] == 1)
            {
                masTabl[0].AddRout(new LineTabl(1, new Router(), new Router(1, 1), 0));
                if (jobM[1] == 1) masTabl[0].AddRout(new LineTabl(2, new Router(2, 2), new Router(1, 3), 1));
                if (jobM[2] == 1) masTabl[0].AddRout(new LineTabl(3, new Router(3, 2), new Router(1, 2), 1));
                if (jobM[4] == 1)
                    if(jobM[2]==1) masTabl[0].AddRout(new LineTabl(5, new Router(3, 2), new Router(1, 2), 2));
                    //else if (jobM[1] == 1) masTabl[0].AddRout(new LineTabl(5, new Router(2, 2), new Router(1, 3), 2));
                if (jobM[1] == 1 && jobM[2] == 1)
                    if (System.Convert.ToInt16(Text12.Text) < System.Convert.ToInt16(Text13.Text))
                        masTabl[0].AddRout(new LineTabl(0, new Router(2, 2), new Router(1, 3), 0));
                    else masTabl[0].AddRout(new LineTabl(0, new Router(3, 2), new Router(1, 2), 0));
                else
                    if (jobM[1] == 1) masTabl[0].AddRout(new LineTabl(0, new Router(2, 2), new Router(1, 3), 0));
                    else
                        if (jobM[2] == 1) masTabl[0].AddRout(new LineTabl(0, new Router(3, 2), new Router(1, 2), 0));
            }
            else masTabl[0].AddRout(new LineTabl(-1, new Router(), new Router(), 0));

            //Заполнение табл маршрутиз № 2
            masTabl[1] = new TablRout();
            if (jobM[1] == 1)
            {
                if (jobM[0] == 1) masTabl[1].AddRout(new LineTabl(1, new Router(1, 3), new Router(2, 2), 1));
                masTabl[1].AddRout(new LineTabl(2, new Router(), new Router(2, 1), 0));
                if (jobM[3] == 1) masTabl[1].AddRout(new LineTabl(4, new Router(4, 2), new Router(2, 3), 1));
                if (jobM[5] == 1 && jobM[3]==1) masTabl[1].AddRout(new LineTabl(6, new Router(4, 2), new Router(2, 3), 2));
                if (jobM[1] == 1 && jobM[3] == 1)
                    if (System.Convert.ToInt16(Text12.Text) < System.Convert.ToInt16(Text24.Text))
                        masTabl[1].AddRout(new LineTabl(0, new Router(1, 3), new Router(2, 2), 0));
                    else masTabl[1].AddRout(new LineTabl(0, new Router(4, 2), new Router(2, 3), 0));
                else
                    if (jobM[1] == 1) masTabl[1].AddRout(new LineTabl(0, new Router(1, 3), new Router(2, 2), 0));
                    else
                        if (jobM[3] == 1) masTabl[1].AddRout(new LineTabl(0, new Router(4, 2), new Router(2, 3), 0));
            }
            //Заполнение табл маршрутиз № 3
            masTabl[2] = new TablRout();
            if (jobM[2] == 1)
            {
                if (jobM[0] == 1) masTabl[2].AddRout(new LineTabl(1, new Router(1, 2), new Router(3, 2), 1));
                if (jobM[0] == 1 && jobM[3] == 1)
                    if (System.Convert.ToInt16(Text13.Text) < System.Convert.ToInt16(Text34.Text))
                        masTabl[2].AddRout(new LineTabl(2, new Router(1, 2), new Router(3, 2), 2));
                    else masTabl[2].AddRout(new LineTabl(2, new Router(4, 3), new Router(3, 4), 2));
                else
                    if (jobM[0] == 1) masTabl[2].AddRout(new LineTabl(2, new Router(1, 2), new Router(3, 2), 2));
                    else
                        if (jobM[3] == 1) masTabl[2].AddRout(new LineTabl(2, new Router(4, 3), new Router(3, 4), 2));
                masTabl[2].AddRout(new LineTabl(3, new Router(), new Router(3, 1), 0));
                if (jobM[3] == 1) masTabl[2].AddRout(new LineTabl(4, new Router(4, 3), new Router(3, 4), 1));
                if (jobM[4] == 1) masTabl[2].AddRout(new LineTabl(5, new Router(5, 2), new Router(3, 3), 1));
                if (jobM[3] == 1 && jobM[4] == 1)
                    if (System.Convert.ToInt16(Text34.Text) < System.Convert.ToInt16(Text35.Text))
                        masTabl[2].AddRout(new LineTabl(6, new Router(4, 3), new Router(3, 4), -1));
                    else masTabl[2].AddRout(new LineTabl(6, new Router(5, 2), new Router(3, 3), -1));
                else
                    if (jobM[3] == 1) masTabl[2].AddRout(new LineTabl(6, new Router(4, 3), new Router(3, 4), -1));
                    else
                        if (jobM[4] == 1) masTabl[2].AddRout(new LineTabl(6, new Router(5, 2), new Router(3, 3), -1));                
            }
            //Заполнение табл маршрутиз № 4
            masTabl[3] = new TablRout();
            if (jobM[3] == 1)
            {
                if (jobM[1] == 1 && jobM[2] == 1)
                    if (System.Convert.ToInt16(Text24.Text) < System.Convert.ToInt16(Text34.Text))
                        masTabl[3].AddRout(new LineTabl(1, new Router(2, 3), new Router(4, 2), 2));
                    else masTabl[3].AddRout(new LineTabl(1, new Router(3, 4), new Router(4, 3), 2));
                else
                    if (jobM[1] == 1) masTabl[3].AddRout(new LineTabl(1, new Router(2, 3), new Router(4, 2), 2));
                    else
                        if (jobM[2] == 1) masTabl[2].AddRout(new LineTabl(1, new Router(3, 4), new Router(4, 3), 2));
                if (jobM[1] == 1) masTabl[3].AddRout(new LineTabl(2, new Router(2, 3), new Router(4, 2), 1));
                if (jobM[2] == 1) masTabl[3].AddRout(new LineTabl(3, new Router(3, 4), new Router(4, 3), 1));
                masTabl[3].AddRout(new LineTabl(4, new Router(), new Router(4, 1), 0));
                if (jobM[2] == 1 && jobM[5] == 1)
                    if (System.Convert.ToInt16(Text34.Text) < System.Convert.ToInt16(Text46.Text))
                        masTabl[3].AddRout(new LineTabl(5, new Router(3, 4), new Router(4, 3), 2));
                    else masTabl[3].AddRout(new LineTabl(5, new Router(6, 2), new Router(4, 4), 2));
                else
                    if (jobM[2] == 1) masTabl[3].AddRout(new LineTabl(5, new Router(3, 4), new Router(4, 3), 2));
                    else
                        if (jobM[5] == 1) masTabl[3].AddRout(new LineTabl(5, new Router(6, 2), new Router(4, 4), 2));
                if (jobM[5] == 1) masTabl[3].AddRout(new LineTabl(6, new Router(6, 2), new Router(4, 4), 1));
            }
            //Заполнение табл маршрутиз № 5
            masTabl[4] = new TablRout();
            if (jobM[4] == 1)
            {
                if (jobM[0] == 1 && jobM[2]==1) masTabl[4].AddRout(new LineTabl(1, new Router(3, 3), new Router(5, 2), 2));
                if (jobM[2] == 1) masTabl[4].AddRout(new LineTabl(3, new Router(3, 3), new Router(5, 2), 1));
                masTabl[4].AddRout(new LineTabl(5, new Router(), new Router(5, 1), 0));
                if (jobM[5] == 1) masTabl[4].AddRout(new LineTabl(6, new Router(6, 3), new Router(5, 3), 1));
                if (jobM[2] == 1 && jobM[5] == 1)
                    if (System.Convert.ToInt16(Text35.Text) < System.Convert.ToInt16(Text56.Text))
                        masTabl[4].AddRout(new LineTabl(0, new Router(3, 3), new Router(5, 2), 0));
                    else masTabl[4].AddRout(new LineTabl(0, new Router(6, 1), new Router(5, 3), 0));
                else
                    if (jobM[2] == 1) masTabl[4].AddRout(new LineTabl(0, new Router(3, 3), new Router(5, 2), 0));
                    else
                        if (jobM[5] == 1) masTabl[4].AddRout(new LineTabl(0, new Router(6, 1), new Router(5, 3), 0));
            }
            //Заполнение табл маршрутиз № 6
            masTabl[5] = new TablRout();
            if (jobM[5] == 1)
            {
                if (jobM[1] == 1 && jobM[3]==1) masTabl[5].AddRout(new LineTabl(2, new Router(4, 4), new Router(6, 2), 2));
                if (jobM[3] == 1) masTabl[5].AddRout(new LineTabl(4, new Router(4, 4), new Router(6, 2), 1));
                if (jobM[4] == 1) masTabl[5].AddRout(new LineTabl(5, new Router(5, 3), new Router(6, 3), 1));
                masTabl[5].AddRout(new LineTabl(6, new Router(), new Router(6, 1), 0));
                if (jobM[3] == 1 && jobM[4] == 1)
                    if (System.Convert.ToInt16(Text46.Text) < System.Convert.ToInt16(Text56.Text))
                        masTabl[5].AddRout(new LineTabl(0, new Router(4, 4), new Router(6, 2), 0));
                    else masTabl[5].AddRout(new LineTabl(0, new Router(5, 3), new Router(6, 3), 0));
                else
                    if (jobM[3] == 1) masTabl[5].AddRout(new LineTabl(0, new Router(4, 4), new Router(6, 2), 0));
                    else
                        if (jobM[4] == 1) masTabl[5].AddRout(new LineTabl(0, new Router(5, 3), new Router(6, 3), 0));
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {
            SetJobM(label1,0);
        }

        void SetJobM(Label ob, int nom)
        {
            if (jobM[nom] == 1)
            {
                jobM[nom] = 0;
                ob.BackColor = System.Drawing.Color.Red;
            }
            else
            {
                jobM[nom] = 1;
                ob.BackColor = System.Drawing.Color.White;
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            for(int i=0; i<6; i++)
            {
                jobM[i] = 1;
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {
            SetJobM(label2, 1);
        }

        private void label3_Click(object sender, EventArgs e)
        {
            SetJobM(label3, 2);
        }

        private void label4_Click(object sender, EventArgs e)
        {
            SetJobM(label4, 3);  
        }

        private void label5_Click(object sender, EventArgs e)
        {
            SetJobM(label5, 4);  
        }

        private void label6_Click(object sender, EventArgs e)
        {
            SetJobM(label6, 5);  
        }
        private void setWidth(DataGridView d)
        {
            for (int i = 0; i < 4; i++)
                d.Columns[i].Width = 50;
        }
        
        private void Rout(int r, List<int> mar)
        {
            count++;
            if (count > 8) MessageBox.Show("Измените параметры маршрутизатора!");
            else
            foreach (LineTabl c in masTabl[r])
            {
                if (c.addrPurp == -1)
                {
                    MessageBox.Show("Нет пути!");
                    break;
                }
                if (c.addrPurp == _addr.Nazn) 
                {
                    mar.Add(c.nextRout.nRout);
                    break;
                }               
                if (c.addrPurp == 0)
                {
                    mar.Add(c.nextRout.nRout);
                    Rout(c.nextRout.nRout-1, mar);
                }
            }           
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (tabM && _addr.Ishod!=0 && _addr.Nazn!=0)
            {
                int m1, m2;
                marshr.Clear();
                Rout(_addr.Ishod - 1, marshr);
                label39.Text = "Маршрут";
                m1 = _addr.Ishod;
                if (count < 9)
                {
                    ColorRout(m1, 0, Application.StartupPath + "//line2.jpg");
                    foreach (int m in marshr)
                    {
                        label39.Text += m.ToString();
                        m2 = m;
                        ColorRout(m1, m2, Application.StartupPath + "//line2.jpg");
                        m1 = m2;
                    }
                    m2 = _addr.Nazn; ColorRout(m1, m2, Application.StartupPath + "//line2.jpg");
                    ColorRout(m2, 0, Application.StartupPath + "//line2.jpg");                    
                }
                MessageBox.Show("Перед поиском нового пути не забудьте нажать кнопку очистить!");
            }
            else MessageBox.Show("Сначала необходимо заполнить таблицы маршрутизации!!! \n Или указать узлы!");
        }
        private void ColorRout(int m1,int m2,string s)
        {
            switch(m1)
            {
                case 1: switch (m2)
                    {
                        case 2: line12.Image = Bitmap.FromFile(s); break;
                        case 3: line13.Image = Bitmap.FromFile(s); break;
                        case 0:
                            {
                                line1.Image = Bitmap.FromFile(s);
                                line111.Image = Bitmap.FromFile(s);
                                line112.Image = Bitmap.FromFile(s);
                            }
                            break;
                    } break;
                case 2: switch (m2)
                    {
                        case 1: line12.Image = Bitmap.FromFile(s); break;
                        case 4: line24.Image = Bitmap.FromFile(s); break;
                        case 0:
                            {
                                line2.Image = Bitmap.FromFile(s);
                                line221.Image = Bitmap.FromFile(s);
                                line222.Image = Bitmap.FromFile(s);
                            } break;
                    } break;
                case 3: switch (m2)
                    {
                        case 1: line13.Image = Bitmap.FromFile(s); break;
                        case 4: line34.Image = Bitmap.FromFile(s); break;
                        case 5: line35.Image = Bitmap.FromFile(s); break;
                        case 0:
                            { 
                                line3.Image = Bitmap.FromFile(s);
                                line331.Image = Bitmap.FromFile(s);
                                line332.Image = Bitmap.FromFile(s);
                            } break;
                    } break;
                case 4: switch (m2)
                    {
                        case 2: line24.Image = Bitmap.FromFile(s); break;
                        case 3: line34.Image = Bitmap.FromFile(s); break;
                        case 6: line46.Image = Bitmap.FromFile(s); break;
                        case 0:
                            {
                                line4.Image = Bitmap.FromFile(s);
                                line441.Image = Bitmap.FromFile(s);
                                line442.Image = Bitmap.FromFile(s);
                            } break;
                    } break;
                case 5: switch (m2)
                    {
                        case 3: line35.Image = Bitmap.FromFile(s); break;
                        case 6: line56.Image = Bitmap.FromFile(s); break;
                        case 0:
                            {
                                line5.Image = Bitmap.FromFile(s);
                                line551.Image = Bitmap.FromFile(s);
                                line552.Image = Bitmap.FromFile(s);
                            } break;
                    } break;
                case 6: switch (m2)
                    {
                        case 4: line46.Image = Bitmap.FromFile(s); break;
                        case 5: line56.Image = Bitmap.FromFile(s); break;
                        case 0:
                            {
                                line6.Image = Bitmap.FromFile(s);
                                line661.Image = Bitmap.FromFile(s);
                                line662.Image = Bitmap.FromFile(s);
                            } break;
                    } break;

            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            tabM = false;
            count = 0;
            int m1, m2;            
            m1 = _addr.Ishod;
            ColorRout(m1, 0, Application.StartupPath + "//line1.jpg");
            foreach (int m in marshr)
            {
                m2 = m;
                ColorRout(m1, m2, Application.StartupPath + "//line1.jpg");
                m1 = m2;
            }
            m2 = _addr.Nazn; ColorRout(m1, m2, Application.StartupPath + "//line1.jpg");
            ColorRout(m2, 0, Application.StartupPath + "//line1.jpg");
            _addr.Ishod = 0;
            _addr.Nazn = 0;
        }
    }
}