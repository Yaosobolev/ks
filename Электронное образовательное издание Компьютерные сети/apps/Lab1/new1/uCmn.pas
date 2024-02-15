unit uCmn;

interface
uses Messages, Types;


const
  CR_DELETE 	= 1;
  CR_ADD			= 2;
  CR_EDIT1		= 3;
  CR_EDIT2		= 4;

  PM_UPDATELIST		= WM_USER+1;

type
	TmDvTypes = (dt_Switch, dt_Workstation, dt_Server);

  //��� ����������� ��������� � ��.
  TmFlrDescription = record
  	LineLn: real;//����� ����� � ��� ��.
    Switches,    //���-�� ������������
  	WStations,	 //������� �������
  	Servers: integer;//��������
		lnCost,      //��������� �����
  	sCost,       //��������� ������������
  	wCost,			 //��������� ������� �������
  	srvCost: real;//��������� ��������
  end;

var
	ExePath: string;





function MakeTPoint(X, Y: integer): TPoint;

implementation

function MakeTPoint(X, Y: integer): TPoint;
begin
	Result.X:= X;
  Result.Y:= Y;
end;

end.
