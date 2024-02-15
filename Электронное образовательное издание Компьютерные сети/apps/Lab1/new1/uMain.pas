unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,
  uLines, StdCtrls, ExtCtrls, ToolWin, ComCtrls, ImgList, CheckLst,
  uDevise,
  uAdvDevises,
  uCmn,
  uFloor,
  ufmFloor;

type
	TmCursorMode	= (cm_Arrow, cm_Line100, cm_Line1000, cm_Connection, cm_Hub8,
  									cm_Hub12, cm_WorkStation, cm_Server);
  TmDoAction		= (da_Add, da_Remove);


  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
		FCListBox: TCheckListBox;

    procedure UpdateForms(var Msg: TMessage); message PM_UPDATELIST;
    procedure LoadFromFile(FName: string);
    procedure SaveToFile(FName: string);
    function CreateFm(sw: boolean): TfmFloor;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses ufmList, ufmAbout, ufmPrice;

{$R *.dfm}
{$R Cursors.res}

type
	TfmFloorInfo = record
  	Name: string[255];
    posX,
    posY: integer;
    visible: boolean;
    DataSize: cardinal;
  end;

procedure TfmMain.LoadFromFile(FName: string);
var
	f: integer;
  finfo: TfmFloorInfo;
  i: integer;
  flrData: TFlrData;
  flrCount: cardinal;
  bytes: cardinal;
  fm: TfmFloor;
  msg: TMessage;
begin
	try
  	F:= CreateFile(PAnsiChar(FName), GENERIC_READ, FILE_SHARE_READ, NIL, OPEN_EXISTING,
                         FILE_ATTRIBUTE_ARCHIVE, 0);
    if F=-1 then
    begin
    	ShowMessage('Ошибка при открытии файла');
      Exit;
    end;

    FCListBox.Clear;

  	ReadFile(F, flrCount, sizeOf(cardinal), bytes, NIL);
    for i:= 0 to flrCount-1 do
    begin
    	ReadFile(F, finfo, sizeOf(TfmFloorInfo), bytes, nil);
      flrData.size:= finfo.DataSize;
      flrData.data:= AllocMem(flrData.size);
      ReadFile(F, flrData.Data^, finfo.DataSize, bytes, nil);
      fm:= CreateFm(TRUE);
      fm.Visible:=	finfo.visible;
      fm.Left:=			finfo.posX;
      fm.Top:=			finfo.posY;
      fm.Floor.FloorName:= finfo.Name;
      fm.Caption:= finfo.Name;
      fm.Floor.Data:= flrData;
    end;
  	FileClose(F);
  except
  end;
  UpdateForms(msg);
end;

procedure TfmMain.SaveToFile(FName: string);
var
	f: integer;
  finfo: TfmFloorInfo;
  i: integer;
  flrData: TFlrData;
  flrCount: cardinal;
  bytes: cardinal;
begin
	try
   	F:= CreateFile(PAnsiChar(FName), GENERIC_READ or GENERIC_WRITE,
                  FILE_SHARE_READ, NIL, OPEN_ALWAYS,
                        FILE_ATTRIBUTE_ARCHIVE, 0);
  	if F=-1 then
    begin
    	ShowMessage('Ошибка при попытке отрытия файла');
      Exit;
    end;
    SetEndOfFile(f);

    flrCount:= FCListBox.Count;
    WriteFile(F, flrCount, SizeOf(cardinal), bytes, nil); //FileSeek(F, 0, 1)

    for i:= 0 to FCListBox.Count-1 do
    begin
    	flrData:= TfmFloor(FCListBox.Items.Objects[i]).Floor.Data;
      if flrData.data=nil then continue;

    	finfo.Name:= TfmFloor(FCListBox.Items.Objects[i]).Floor.FloorName;
      finfo.posX:= TfmFloor(FCListBox.Items.Objects[i]).Left;
			finfo.posY:= TfmFloor(FCListBox.Items.Objects[i]).Top;
      finfo.visible:= TfmFloor(FCListBox.Items.Objects[i]).Visible;
    	finfo.DataSize:= flrData.size;
      WriteFile(F, finfo, SizeOf(TfmFloorInfo), bytes, NIL);
      WriteFile(F, flrData.data^, flrData.size, bytes, NIL);
      FreeMem(flrData.data, flrData.size);
    end;

   	FileClose(F);
  except
  end;
end;

procedure TfmMain.UpdateForms(var Msg: TMessage);
var
	i: integer;
begin
  for i:= 0 to FCListBox.Count-1 do
  begin
  	FCListBox.Items[i]:= TfmFloor(FCListBox.Items.Objects[i]).Floor.FloorName;
    FCListBox.Checked[i]:= TfmFloor(FCListBox.Items.Objects[i]).Visible;
  end;
end;

procedure TfmMain.N2Click(Sender: TObject);
begin
	Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
	ExePath:= ExtractFilePath(Application.ExeName);
	//Height:= 45;
                                
  Screen.Cursors[CR_DELETE]:= LoadCursor(HInstance, 'CRDELETE');
  Screen.Cursors[CR_ADD]:= LoadCursor(HInstance, 'CRADD');
  Screen.Cursors[CR_EDIT1]:= LoadCursor(HInstance, 'EDIT1');
	Screen.Cursors[CR_EDIT2]:= LoadCursor(HInstance, 'EDIT2');

  FCListBox:= TCheckListBox.Create(Self);
  FCListBox.Parent:= Self;
  FCListBox.Visible:= FALSE;
end;

function TfmMain.CreateFm(sw: boolean): TfmFloor;
var
	Floor: TfmFloor;
  i: integer;
begin
	Floor:= TfmFloor.Create(Application);
  Floor.Visible:= sw;
  Floor.Floor:= TmFloor.Create(Floor);

	i:= FCListBox.Items.AddObject(Floor.Floor.FloorName, Floor);
  FCListBox.Checked[i]:= Floor.Visible;

	Result:= Floor;
end;

procedure TfmMain.N8Click(Sender: TObject);
var
	i: integer;
begin
  for i:= 0 to FCListBox.Count-1 do
	 	if FCListBox.Items.Objects[i] is TfmFloor then
     	TfmFloor(FCListBox.Items.Objects[i]).Free;
  FCListBox.Clear;
end;

procedure TfmMain.N9Click(Sender: TObject);
begin
	OpenDialog1.FileName:= ExtractFilePath(Application.ExeName)+'*.ntp';
	if OpenDialog1.Execute then
  	LoadFromFile(OpenDialog1.FileName);
end;

procedure TfmMain.N10Click(Sender: TObject);
begin
	SaveDialog1.FileName:= ExtractFilePath(Application.ExeName)+'*.ntp';
	if SaveDialog1.Execute then
  	SaveToFile(SaveDialog1.FileName);
end;

procedure TfmMain.N3Click(Sender: TObject);
begin
	TfmAbout.Create(Application).ShowModal;
end;

procedure TfmMain.Button1Click(Sender: TObject);
begin
  CreateFm(TRUE);
end;

procedure TfmMain.Button3Click(Sender: TObject);
var
	fmList: TfmList;
  res, i: integer;
begin
	//список этажей
	fmList:= TfmList.Create(Application);
  fmList.CBox:= FCListBox;
  res:= fmList.ShowModal;//1-OK; 2- Отмена
  if res = 2 then Exit;

  for i:= 0 to FCListBox.Count-1 do
	 	if FCListBox.Items.Objects[i] is TfmFloor then
    	if FCListBox.Checked[i] then TfmFloor(FCListBox.Items.Objects[i]).Show
      else TfmFloor(FCListBox.Items.Objects[i]).Hide;
end;

procedure TfmMain.Button2Click(Sender: TObject);
var
	fmList: TfmList;
  res, i: integer;
begin
	//удалить этаж
	fmList:= TfmList.Create(Application);
  fmList.CBox:= FCListBox;
  res:= fmList.ShowModal;//1-OK; 2- Отмена
  if res = 2 then Exit;


  for i:= 0 to FCListBox.Count-1 do
	 	if FCListBox.Items.Objects[i] is TfmFloor then
    	if FCListBox.Checked[i] then
      begin
      	TfmFloor(FCListBox.Items.Objects[i]).Free;
        FCListBox.Items.Delete(i);
        Break;
      end;
end;

procedure TfmMain.Button4Click(Sender: TObject);
var
	fm: TfmPrice;
begin
	fm:= TfmPrice.Create(Application);
  fm.CBox:= FCListBox;
  fm.Show;
end;

end.
