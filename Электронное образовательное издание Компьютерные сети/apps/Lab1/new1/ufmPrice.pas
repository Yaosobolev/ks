unit ufmPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CheckLst, IniFiles;

type
  TfmPrice = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edLine: TEdit;
    edOptic: TEdit;
    edSwitch: TEdit;
    edWStation: TEdit;
    edServer: TEdit;
    Button1: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    procedure edLineChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CBox: TCheckListBox;
  end;

var
  fmPrice: TfmPrice;

implementation

uses ufmFloor, uLines, uDevise, uCmn, uFloor, ufmCost;

{$R *.dfm}


procedure TfmPrice.edLineChange(Sender: TObject);
begin
  try
  	StrToFloat(TEdit(Sender).Text);
  except
  	ShowMessage('недопустимое значение!');
  end;
end;

procedure TfmPrice.FormCreate(Sender: TObject);
var
	ini: TIniFile;
begin
	ini:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'price.ini');
	try
  	edLine.Text:= ini.ReadString('PRICE', 'Line', '0');
	  edOptic.Text:= ini.ReadString('PRICE', 'Optic', '0');
	  edSwitch.Text:= ini.ReadString('PRICE', 'Switch', '0');
  	edWStation.Text:= ini.ReadString('PRICE', 'WStation', '0');
	  edServer.Text:= ini.ReadString('PRICE', 'Server', '0');
  finally
  	ini.Free;
  end;
end;

procedure TfmPrice.FormClose(Sender: TObject; var Action: TCloseAction);
var
	ini: TIniFile;
begin
  ini:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'price.ini');
  try
  	ini.WriteString('PRICE', 'Line', edLine.Text);
    ini.WriteString('PRICE', 'Optic', edOptic.Text);
    ini.WriteString('PRICE', 'Switch', edSwitch.Text);
    ini.WriteString('PRICE', 'WStation', edWStation.Text);
    ini.WriteString('PRICE', 'Server', edServer.Text);
  finally
  	ini.Free;
  end;
end;

procedure TfmPrice.Button1Click(Sender: TObject);
var
	i: integer;
  flr, flr1: TmFlrDescription;
  fm: TfmCost;
begin
	LNCOSTS[lt_line]:= StrToFloat(edLine.Text);
  LNCOSTS[lt_optic]:= StrToFloat(edOptic.Text);
  DEVCOST[dt_Switch]:= StrToFloat(edSwitch.Text);
  DEVCOST[dt_Workstation]:= StrToFloat(edWStation.Text);
  DEVCOST[dt_Server]:= StrToFloat(edServer.Text);

  FillMemory(@flr, SizeOf(flr), 0);
  for i:= 0 to CBox.Count-1 do
  	if CBox.Items.Objects[i] is TfmFloor then
    begin
    	flr1:= TfmFloor(CBox.Items.Objects[i]).Floor.Description;

    	flr.LineLn:=		flr.LineLn + flr1.LineLn;
			flr.Switches:=	flr.Switches + flr1.Switches;
			flr.WStations:=	flr.WStations + flr1.WStations;
      flr.Servers:=		flr.Servers + flr1.Servers;
      flr.lnCost:=		flr.lnCost + flr1.lnCost;
      flr.sCost:=			flr.sCost + flr1.sCost;
      flr.wCost:=			flr.wCost + flr1.wCost;
      flr.srvCost:=		flr.srvCost + flr1.srvCost;
    end;

  fm:= TfmCost.Create(Application);
  fm.Description:= flr;
  fm.ShowModal;
end;

procedure TfmPrice.Edit1Change(Sender: TObject);
var
	i: integer;
begin
	try
  	i:= StrToInt(TEdit(Sender).Text);
    if i<=0 then TEdit(Sender).Text:= '1';
  except
  	ShowMessage('недопустимое значение!');
  end;
end;

procedure TfmPrice.Edit1Exit(Sender: TObject);
var
	i: integer;
  s: integer;
begin
	try
  	s:= StrToInt(TEdit(Sender).Text);
  except
  	Exit;
  end;
  for i:= 0 to CBox.Count-1 do
  	if CBox.Items.Objects[i] is TfmFloor then
    begin
    	TfmFloor(CBox.Items.Objects[i]).Floor.Scale:= s;
    end;
end;

end.
