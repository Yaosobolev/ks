unit ufmFloor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ImgList, ComCtrls, ToolWin,
  uFloor,
  uCmn;

type
  TfmFloor = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton11: TToolButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    mnFloors: TMenuItem;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    N1: TMenuItem;
    ColorDialog1: TColorDialog;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    { Private declarations }
    FFloor: TmFloor;

    procedure SetFloor(f: TmFloor);
  public
    { Public declarations }
    property Floor: TmFloor read FFloor write SetFloor;
  end;


implementation

{$R *.dfm}

procedure TfmFloor.SetFloor(f: TmFloor);
begin
	FFloor:= F;
  FFloor.Parent:= Self.Panel1;
  Caption:= FFloor.FloorName;
end;

procedure TfmFloor.ToolButton12Click(Sender: TObject);
begin
	FFloor.Grid:= ToolButton12.Down;
end;

procedure TfmFloor.ToolButton10Click(Sender: TObject);
begin
	FFloor.Edit:= ToolButton10.Down;
end;

procedure TfmFloor.ToolButton6Click(Sender: TObject);
begin
	FFloor.Operation:= mo_Switch5;
end;

procedure TfmFloor.ToolButton5Click(Sender: TObject);
begin
  FFloor.Operation:= mo_Switch24;
end;

procedure TfmFloor.FormCreate(Sender: TObject);
begin
  Panel1.DoubleBuffered:= TRUE;
end;

procedure TfmFloor.ToolButton14Click(Sender: TObject);
begin
	FFloor.Tool:= mss_Empty;
end;

procedure TfmFloor.ToolButton15Click(Sender: TObject);
begin
	FFloor.Tool:= mss_Wall;
end;

procedure TfmFloor.ToolButton1Click(Sender: TObject);
begin
	FFloor.Operation:= mo_Arrow;
end;

procedure TfmFloor.ToolButton11Click(Sender: TObject);
begin
  FFloor.Operation:= mo_Delete;
end;

procedure TfmFloor.ToolButton2Click(Sender: TObject);
begin
	FFloor.Operation:= mo_Line;
end;

procedure TfmFloor.ToolButton3Click(Sender: TObject);
begin
	FFloor.Operation:= mo_OpticLine;
end;

procedure TfmFloor.ToolButton7Click(Sender: TObject);
begin
  FFloor.Operation:= mo_Workstation;
end;

procedure TfmFloor.ToolButton8Click(Sender: TObject);
begin
	FFloor.Operation:= mo_Server;
end;

procedure TfmFloor.N1Click(Sender: TObject);
begin
	InputQuery('���� ��������', '������� ���:', FFloor.FloorName);
  Caption:= FFloor.FloorName;
  PostMessage(Application.MainForm.Handle, PM_UPDATELIST, 0, 0);
end;

procedure TfmFloor.N3Click(Sender: TObject);
begin
	ColorDialog1.Color:= FFloor.GridColor;
	if ColorDialog1.Execute then
  	FFloor.GridColor:= ColorDialog1.Color;
end;

procedure TfmFloor.N4Click(Sender: TObject);
var
	s: string;
begin
	try
  	s:= IntToStr(FFloor.GridWidth);
    InputQuery('���� ��������', '������� ��� �����', s);
    FFloor.GridWidth:= StrToInt(s);
  except
  	ShowMessage('������������ ��������!');
  end;
end;

procedure TfmFloor.N6Click(Sender: TObject);
begin
	ColorDialog1.Color:= FFloor.GetColors(mss_Wall);
	if ColorDialog1.Execute then
		FFloor.SetColors(mss_Wall, ColorDialog1.Color);
end;

procedure TfmFloor.N7Click(Sender: TObject);
begin
	ColorDialog1.Color:= FFloor.GetColors(mss_Empty);
	if ColorDialog1.Execute then
		FFloor.SetColors(mss_Empty, ColorDialog1.Color);
end;

procedure TfmFloor.N9Click(Sender: TObject);
begin
	if MessageDlg('�������� ����?',
  							 mtConfirmation,[mbOK, mbCancel],0)=mrCancel then Exit;
  FFloor.Clear;
end;

procedure TfmFloor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action:= caHide;
  PostMessage(Application.MainForm.Handle, PM_UPDATELIST, 0, 0);
end;

procedure TfmFloor.FormDestroy(Sender: TObject);
begin
	FFloor.Free;
end;

procedure TfmFloor.N10Click(Sender: TObject);
var
	flr: TmFlrDescription;
  s: string;
begin
  flr:= Floor.Description;
  s:= 
  '���������: ������'+#10#13+
  '������������ '		+IntToStr(flr.Switches)+#10#13+
  '������� ������� '+IntToStr(flr.WStations)+#10#13+
  '�������� '	 			+IntToStr(flr.Servers);

  ShowMessage(S);
end;

end.
