unit uDevise;

interface
uses Types, Classes, SysUtils, Controls, Graphics, ExtCtrls, uLines, uCmn;

const
	MAX_DEVNAME					= 50;
  DEFAULT_SELECTCOLOR	= clRed;
  DEFAULT_SELECTWIDTH	= 1;

type
	TmDevice = class;

  TmConnection = record
		device: TmDevice;
    line:		TmLine;
  end;

	TmMessages = (mm_Ping, mm_Rmv);
	TmMesInfo = record
  	Mes: TmMessages;
  	sDev,
    rDev: TmDevice;
    rLine: TmLine;
  end;

  TmDevice = class(TImage)
	protected
  	FDType: TmDvTypes;
  	FSelected: boolean;//признак "выделенности"
    FOrigPic: TPicture; //для восстановления картинки
    FSelectColor:	TColor; //цвет рамки выделения

    FRmtDevices,
    FLines: Tlist;
    FCount: integer;

    FCost: real;

    procedure SetSelection(b: boolean);//сделать выделенным/невыделенным
    function GetDeviceInfoStr: string; virtual;
    procedure SetPosition(p: TPoint);
    function GetPosition: TPoint;
    procedure SetCount(i: integer);
    function GetCost: real;
  public
		ID:			 integer;//идентификатор
    DevName: string[MAX_DEVNAME];//имя устройства

    constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;

    procedure Select;//выделить
    function Under(x,y: integer): boolean;//TRUE, если под указанными координатами
    procedure AddConnection(dev: TmDevice; line: TmLine); virtual;
    procedure RemoveConnection(dev: TmDevice); virtual;
    function GetConnectionPos(i: integer): TPoint; virtual;
    procedure mMesage(mes: TmMesInfo); virtual; abstract;

    property Selected: boolean read FSelected write SetSelection;
    property DeviceInfoStr: string read GetDeviceInfoStr;
		property Position: TPoint read GetPosition write SetPosition;
    property RmtDevList: TList read FRmtDevices;
    property Lines: TList read FLines;
    property DType: TmDvTypes read FDType;
    property Cost: real read GetCost write FCost;
  end;


var
	DEVCOST: array[TmDvTypes]of real;
  
implementation



function TmDevice.GetCost: real;
begin
	if FCost>0 then Result:= FCost
  else Result:= DEVCOST[FDType];
end;

procedure TmDevice.RemoveConnection(dev: TmDevice);
var
	i: integer;
begin
	i:= FRmtDevices.IndexOf(dev);
  if i=-1 then Exit;

  FRmtDevices.Delete(i);
  TmLine(FLines[i]).RemPoint(GetConnectionPos(i));
  FLines.Delete(i);
end;

procedure TmDevice.AddConnection(dev: TmDevice; line: TmLine);
begin
 	if FRmtDevices.IndexOf(dev)<>-1 then raise Exception.Create('Уже соединены!');

	if FCount<FRmtDevices.Count+1 then raise Exception.Create('Свободных портов нет! Допустимо не более '+IntToStr(FCount)+' подключений.');
  	
	FRmtDevices.Add(dev);
  FLines.Add(line);
  Line.AddPoint(GetConnectionPos(FLines.IndexOf(line)));
end;

procedure TmDevice.SetCount(i: integer);
begin
	if FRmtDevices.Count>0 then Exit;
  FCount:= i;
end;

function TmDevice.GetConnectionPos(i: integer): TPoint;
begin
	Result:= GetPosition;
end;

procedure TmDevice.SetPosition(p: TPoint);
begin
	Left:= p.X-(Width div 2);
	Top:= p.Y-(Height div 2);
end;

function TmDevice.GetPosition: TPoint;
begin
	Result.X:= Left+(Width div 2);
  Result.Y:= Top+(Height div 2);
end;

function TmDevice.GetDeviceInfoStr: string;
begin
	Result:= 'неопределенное'+#10#13+
  				 'устройство';
end;

function TmDevice.Under(x,y: integer): boolean;
begin
	Result:= (x>=Left)and(x<=(Left+Width))and
  					(y>=Top)and(y<=(Top+Height));
end;

constructor TmDevice.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
  FOrigPic:= TPicture.Create;
  FSelectColor:= DEFAULT_SELECTCOLOR;

  FRmtDevices:= TList.Create;
  FLines:= TList.Create;
end;

destructor TmDevice.Destroy;
begin
	if Assigned(FOrigPic) then FOrigPic.Free;
  FRmtDevices.Free;
  FLines.Free;

  inherited Destroy;
end;

procedure TmDevice.SetSelection(b: boolean);
var
	delta: integer;
begin
	FSelected:= b;
  if FSelected then
  begin
  	delta:= DEFAULT_SELECTWIDTH div 2;
		with Canvas do
	  begin
    	Pen.Color:= FSelectColor;
			Pen.Width:= DEFAULT_SELECTWIDTH;
      MoveTo(0+delta,				Height-2);
      LineTo(0+delta, 			0+delta);
      LineTo(Width-delta-1,	0+delta);
      LineTo(Width-delta-1,	Height-delta-1);
      LineTo(0+1,						Height-delta-1);
      Exit;
	  end
  end
  else Picture.Assign(FOrigPic);
end;

procedure TmDevice.Select;
begin
	Selected:= TRUE;
end;

end.
