unit uFloor;

interface
uses Windows, Classes, Controls, Graphics, ExtCtrls, Dialogs,
			uDevise,
			uAdvDevises,
      uLines,
      ufmInfo,
      uCmn;



type
	TmOperation = (mo_Arrow, mo_Delete, mo_Line, mo_OpticLine, mo_Switch5,
  								mo_Switch24, mo_Workstation, mo_Server);

  TmStates = (mss_Empty, mss_Wall);
  TmFloorColors = array [TmStates]of TColor;	//��������� ���� �����
  TmField = array of array of TmStates;	//���� �����

const
	MAX_DEVCOUNT	= 24;
	DEF_FLOORNAME	= '���������� ����';
	DEF_COLORS: TmFloorColors = ($00E7E9E0, $001B1812);
  DEF_GRIDCOLOR = $00D7EA8A;
  DEF_GRIDWIDTH = 8;


type
  TFlrData = record
  	size: cardinal;
    data: PChar;
  end;

  TmFloor = class
	protected
  	FPBox: TPaintBox;//���� ���������
    FParent: TWinControl;//�������� ��� ����
    FGridColor: TColor;//���� �����
    FGridWidth: integer;//��� �����
    FGrid: boolean;//�������� �����
    FCellsX,
    FCellsY: integer;//���������� ����� ����� �� ����������� � ���������

    FFloorColors: TmFloorColors;//����� ��� ��������� ����
    FTool: TmStates;
    FOperation: TmOperation;
    FField: TmField;//����
    FEdit: boolean;

    FDevises,
    FLines: TList;
    FInfoWindow: TfmInfo;

    FTmpDevice: TmDevice;


    procedure DrawGrid;
    procedure SetParent(p: TWinControl);
    procedure SetGrid(b: boolean);
    procedure SetGridColor(c: TColor);
    procedure SetGridWidth(w: integer);
    procedure SetTool(t: TmStates);
    procedure SetOperation(o: TmOperation);
    procedure SetEdit(b: boolean);
    procedure ShowInfo(x,y: integer; Dev: TmDevice);
    procedure HideInfo;
    procedure DoOperation(x,y: integer; Dev: TmDevice=nil);
    procedure ConnectDevices(dev1, dev2: TmDevice; lt: TmLineTypes; ms: boolean=TRUE);
    procedure SetData(d: TFlrData);
    function GetData: TFlrData;
    function GetLnLength: real;
    function GetLnCost: real;
    function GetDescr: TmFlrDescription;
    procedure SetScale(s: integer);

    procedure PBoxPaint(Sender: TObject);
    procedure PBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    FloorName: string;//���������

  	constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure UpdateState;
    procedure DrawUnderPoint(x,y: integer);
    procedure SetColors(i: TmStates; clr: TColor);
    function GetColors(i: TmStates): TColor;
    procedure Clear;

    property Parent: TWinControl read FParent write SetParent;
    property Grid: boolean read FGrid write SetGrid;
    property GridColor: TColor read FGridColor write SetGridColor;
    property GridWidth: integer read FGridWidth write SetGridWidth;
    property Tool: TmStates read FTool write SetTool;
    property Operation: TmOperation read FOperation write SetOperation;
    property Edit: boolean read FEdit write SetEdit;
    property Data: TFlrData read GetData write SetData;
    property LnLength: real read GetLnLength;
    property LnCost: real read GetLnCost;
    property Description: TmFlrDescription read GetDescr;
    property Scale: integer write SetScale;
  end;

implementation

uses SysUtils, Math;



procedure TmFloor.SetScale(s: integer);
var
	i: integer;
begin
	for i:= 0 to FLines.Count-1 do
  begin
  	TmLine(FLines[i]).Scale:= s;
  end;
end;

function TmFloor.GetDescr: TmFlrDescription;
var
	i: integer;
begin
	FillMemory(@Result, SizeOf(TmFlrDescription), 0);
  
	Result.LineLn:= LnLength;
  Result.lnCost:= LnCost;

  for i:= 0 to FDevises.Count-1 do
  begin
  	case TmDevice(FDevises[i]).DType of
    dt_Switch:
    	begin
      	inc(Result.Switches);
        Result.sCost:= Result.sCost + TmDevice(FDevises[i]).Cost;
      end;
    dt_Workstation:
    	begin
      	inc(Result.WStations);
        Result.wCost:= Result.wCost + TmDevice(FDevises[i]).Cost;
      end;
    dt_Server:
    	begin
      	inc(Result.Servers);
        Result.srvCost:= Result.srvCost + TmDevice(FDevises[i]).Cost;
      end;
    end;
  end;
end;

function TmFloor.GetLnCost: real;
var
	i: integer;
begin
  Result:= 0;
  for i:= 0 to FLines.Count-1 do
  	Result:= Result + TmLine(FLines[i]).Cost;
end;

function TmFloor.GetLnLength: real;
var
	i: integer;
begin
	Result:= 0;
  for i:= 0 to FLines.Count-1 do
  	Result:= Result + TmLine(FLines[i]).Length;
end;

type
	TmFlrinfo = record
		grdColor: TColor;
  	grdWidth: integer;
  	grdDraw: boolean;
		flrColors: TmFloorColors;
		tool: TmStates;
		oper: TmOperation;
		edit: boolean;
  	fieldX,
    fieldY: integer;
		dvcount: integer;
  end;
  TConInfo = record
  	lineType: TmLineTypes;
    num: integer;
  end;
  TDevInfo = record
  	ID: integer;
    Name: string[MAX_DEVNAME];
    rmCount: integer;
    position: TPoint;
    dvtype: TmDvTypes;
    pcount: integer;
    rmDevices: array[0..MAX_DEVCOUNT-1] of TConInfo;//������ ������� ������������ �-�
  end;

procedure TmFloor.SetData(d: TFlrData);
var
	flrInfo: TmFlrInfo;
  dvs: array of TDevInfo;
  i, j: integer;
  ptr: integer;
  dv, dv2: TmDevice;
begin
	CopyMemory(@flrInfo, @d.data[0], SizeOf(flrInfo));
  FGridColor:=	flrInfo.grdColor;
  FGridWidth:=  flrInfo.grdWidth;
  FGrid:=				flrInfo.grdDraw;
  FFloorColors:=flrInfo.flrColors;
  FTool:=				flrInfo.tool;
  FOperation:=	flrInfo.oper;
  FEdit:=				flrInfo.edit;

  //����
  ptr:= SizeOf(flrInfo);
  SetLength(FField, flrInfo.fieldX, flrInfo.fieldY);
  for i:= 0 to flrInfo.fieldX-1 do
  begin
  	for j:= 0 to flrInfo.fieldY-1 do
  		CopyMemory(@FField[i,j], @D.data[ptr+(j*SizeOf(TmStates))], SizeOf(TmStates));
    ptr:= ptr + SizeOf(TmStates)*flrInfo.fieldY;
  end;

  //�-��
  SetLength(dvs, flrInfo.dvcount);
  for i:= 0 to flrInfo.dvcount-1 do
  begin
    CopyMemory(@dvs[i], @d.data[ptr], SizeOf(TDevInfo));
    ptr:= ptr + SizeOf(TDevInfo);
  end;

  for i:= 0 to flrInfo.dvcount-1 do
  begin
  	dv:= nil;
		case dvs[i].dvtype of
    dt_Switch:
    	begin
      	dv:= TmSwitch.Create(FPBox);
        TmSwitch(dv).Count:= dvs[i].pcount;
      end;
    dt_Workstation:	dv:= TmWorkstation.Create(FPBox);
    dt_Server:			dv:= TmServer.Create(FPBox);
    end;
    if dv=nil then Continue;
    
    dv.Parent:=				FPBox.Parent;
		dv.Position:=			dvs[i].position;
    dv.ID:=						dvs[i].ID;
    dv.DevName:=			dvs[i].Name;
		Dv.OnMouseDown:=	PBoxMouseDown;
		FDevises.Add(Dv);
  end;

  //����������
  for i:= 0 to flrInfo.dvcount-1 do
  begin
  	for j:= 0 to dvs[i].rmCount-1 do
    begin
    	if dvs[i].rmDevices[j].num>-1 then
      begin
        dv:= TmDevice(FDevises[i]);
        dv2:= TmDevice(FDevises[dvs[i].rmDevices[j].num]);
        ConnectDevices(dv, dv2, dvs[i].rmDevices[j].lineType, FALSE);
      end;
    end;
  end;

  SetLength(dvs, 0);
  FreeMem(d.data, d.size);
  UpdateState;
end;

function TmFloor.GetData: TFlrData;
var
	Data: PChar;
  flrInfo: TmFlrinfo;
  dvinfo: TDevInfo;
  i, j: integer;
  ptr: integer;
  tmpList, tmpList1: TList;
begin
	result.size:= 0;
  Result.data:= nil;

  flrInfo.grdColor:=	FGridColor;
  flrInfo.grdWidth:=	FGridWidth;
  flrInfo.grdDraw:=		FGrid;
  flrInfo.flrColors:=	FFloorColors;
  flrInfo.tool:=			FTool;
  flrInfo.oper:=			FOperation;
  flrInfo.edit:=			FEdit;
  flrInfo.fieldX:=		Length(FField);
  flrInfo.fieldY:=		Length(FField[0]);

  flrInfo.dvcount:= 	FDevises.Count;

  //����� ��� ������
  Result.size:= SizeOf(flrInfo)+((flrInfo.fieldX*flrInfo.fieldY)*SizeOf(TmStates))+(flrInfo.dvcount*sizeof(dvinfo));
  Data:= AllocMem(Result.size);
  CopyMemory(@Data[0], @flrInfo, SizeOf(flrInfo));//

  //����
  ptr:= SizeOf(flrInfo);
  for i:= 0 to flrInfo.fieldX-1 do
  begin
  	for j:= 0 to flrInfo.fieldY-1 do
  		CopyMemory(@Data[ptr+(j*SizeOf(TmStates))], @FField[i,j], SizeOf(TmStates));
    ptr:= ptr + SizeOf(TmStates)*flrInfo.fieldY;
  end;

  //����������
  for i:= 0 to flrInfo.dvcount-1 do
  begin
  	dvinfo.ID:=				TmDevice(FDevises[i]).ID;
    dvinfo.Name:=			TmDevice(FDevises[i]).DevName;
    dvinfo.position:=	TmDevice(FDevises[i]).Position;
    dvinfo.dvtype:=		TmDevice(FDevises[i]).DType;

    if TmDevice(FDevises[i]).DType=dt_Switch then
    	dvinfo.pcount:=		TmSwitch(FDevises[i]).Count;

    tmpList:= TmDevice(FDevises[i]).RmtDevList;
    tmpList1:=	TmDevice(FDevises[i]).Lines;
    dvinfo.rmCount:= tmpList.Count;
    for j:= 0 to dvinfo.rmCount-1 do
    begin
    	dvinfo.rmDevices[j].num:= FDevises.IndexOf(tmpList[j]);
      dvinfo.rmDevices[j].lineType:= TmLine(FLines[FLines.IndexOf(tmpList1[j])]).LType;
    end;

  	CopyMemory(@Data[ptr], @dvinfo, SizeOf(dvInfo));
    ptr:= ptr+SizeOf(dvInfo);
	end;

  Result.data:= Data;
end;

procedure TmFloor.ConnectDevices(dev1, dev2: TmDevice; lt: TmLineTypes; ms: boolean=TRUE);
var
	line: TmLine;
begin
	line:= TmLine.Create;
	line.Canvas:= FPBox.Canvas;
  line.LType:= lt;
	try
		Dev1.AddConnection(dev2, line);
		dev2.AddConnection(dev1, line);
  except
		on E: Exception do
		begin
    	if ms then ShowMessage(E.Message);
			line.Free;
			Exit;
		end;
  end;
	FLines.Add(line);
end;

procedure TmFloor.Clear;
var
	i, j: integer;
begin
	//��������� ���� ��������
	for i:= 0 to FCellsX-1 do
		for j:= 0 to FCellsY-1 do FField[i,j]:= mss_Empty;
  //������� ��� ����������
  for i:= 0 to FDevises.Count-1 do
  	TmDevice(FDevises[i]).Free;
  FDevises.Clear;
  //������� ��� �����
  for i:= 0 to FLines.Count-1 do
  	TmLine(Flines[i]).Free;
  FLines.Clear;

  UpdateState;
end;

procedure TmFloor.HideInfo;
begin
	if fmInfo<>nil then fmInfo.Visible:= FALSE;
end;

procedure TmFloor.ShowInfo(x,y: integer; Dev: TmDevice);
begin
	if FParent=nil then Exit;
	if fmInfo=nil then fmInfo:= TfmInfo.Create(FParent);

  fmInfo.Left:= FParent.Parent.Left+Dev.Left+x;
  fmInfo.Top:= 	FParent.Parent.Top+Dev.Top+y;
  fmInfo.Label1.Caption:=	Dev.DeviceInfoStr;
  fmInfo.Visible:= 				TRUE;
end;

function TmFloor.GetColors(i: TmStates): TColor;
begin
	Result:= FFloorColors[i];
end;

procedure TmFloor.SetColors(i: TmStates; clr: TColor);
begin
	FFloorColors[i]:= clr;
  FPBox.Invalidate;
end;

procedure TmFloor.SetEdit(b: boolean);
var
	i: integer;
begin
	FEdit:= b;
	for i:= 0 to FDevises.Count-1 do TmDevice(FDevises[i]).Visible:= not FEdit;
  for i:= 0 to FLines.Count-1 do TmLine(FLines[i]).Visible:= not FEdit;
  UpdateState;
end;

procedure TmFloor.DoOperation(x, y: integer; Dev: TmDevice=nil);
var
  i: integer;
begin
  if ((FTmpDevice<>nil)AND(Dev=nil))or((FTmpDevice<>nil)AND(FTmpDevice=Dev)) then//����� ���������
  begin
  	FTmpDevice.Selected:= FALSE;
  	FTmpDevice:= nil;
  end;

	case FOperation of
  mo_Arrow:
  	begin
     	if Dev<>nil then
      begin
   			ShowInfo(x, y, Dev);
     		Exit;
      end;
    end;
  mo_Delete: //�������� ����������
  	begin
    	if Dev<>nil then//�������� �� ������
      begin
        //�������� ����������
      	i:= FDevises.IndexOf(Dev);
        Dev.Free;
        if i>=0 then FDevises.Delete(i);
        UpdateState;
        Exit;
      end else//�������� �� �����������, ���� ������ ����
    	for i:= 0 to FDevises.Count-1 do
    		if TmDevice(FDevises[i]).Under(x,y) then
        begin
          TmDevice(FDevises[i]).Free;
          FDevises.Delete(i);
          Exit;
        end;
    end;
  mo_Line, mo_OpticLine://���������� ���������
  	begin
      if Dev<>nil then
      begin
      	if FTmpDevice<>nil then
        begin
        	if FOperation=mo_Line then ConnectDevices(Dev, FTmpDevice, lt_line)
          else ConnectDevices(Dev, FTmpDevice, lt_optic);
          FTmpDevice.Selected:= FALSE;
					FTmpDevice:= nil;
					UpdateState;
					Exit;
        end else
        begin
      		FTmpDevice:= Dev;
        	FTmpDevice.Select;
        	Exit;
        end;
      end;
    end;
  mo_Switch5:
  	begin
    	Dev:= TmSwitch.Create(FPBox);
      TmSwitch(Dev).Count:= 5;
    end;
  mo_Switch24:
  	begin
    	Dev:= TmSwitch.Create(FPBox);
      TmSwitch(Dev).Count:= 24;
    end;
  mo_Workstation:	Dev:= TmWorkstation.Create(FPBox);
  mo_Server:			Dev:= TmServer.Create(FPBox);
  end;

	if Dev is TmDevice then
  begin
	  Dev.Parent:= FPBox.Parent;
    Dev.Position:= MakeTPoint(x,y);
    Dev.OnMouseDown:= PBoxMouseDown;
		FDevises.Add(Dev);
  end;
end;

procedure TmFloor.SetOperation(o: TmOperation);
begin
	FOperation:= o;
  UpdateState;
end;

procedure TmFloor.SetTool(t: TmStates);
begin
	FTool:= t;
  UpdateState;
end;

procedure TmFloor.DrawUnderPoint(x,y: integer);
var
	toX, toY: integer;
begin
	toX:= X div FGridWidth;
  toY:= Y div FGridWidth;
  if toX<0 then Exit;
  if toY<0 then Exit;
  if toX>FCellsX-1 then Exit;
  if toY>FCellsY-1 then Exit;
	FField[toX, toY]:= FTool;
  FPBox.Invalidate;
end;

procedure TmFloor.SetGridWidth(w: integer);
begin
	FGridWidth:= w;
  UpdateState;
end;

procedure TmFloor.UpdateState;
var
	i: integer;
begin
	FCellsX:= FPBox.Width div Max(FGridWidth, DEF_GRIDWIDTH);
  FCellsY:= FPBox.Height div Max(FGridWidth, DEF_GRIDWIDTH);
  SetLength(FField, FCellsX, FCellsY);

  //��� �������
  if FEdit then
  begin
  	case FTool of
    mss_Empty:	FPBox.Cursor:= CR_EDIT1;
    mss_Wall:		FPBox.Cursor:= CR_EDIT2;
    end;
  end else
  begin
  	case Operation of
    mo_Arrow:
    	begin
      	 FPBox.Cursor:= crDefault;
         for i:= 0 to FDevises.Count-1 do TmDevice(FDevises[i]).Cursor:= crHandPoint;
      end;
    mo_Delete:
    	begin
        FPBox.Cursor:= crDefault;
      	for i:= 0 to FDevises.Count-1 do TmDevice(FDevises[i]).Cursor:= CR_DELETE;
      end;
    mo_Line, mo_OpticLine,
     mo_Switch5, mo_Switch24,
     mo_Workstation, mo_Server:
     begin
     	FPBox.Cursor:= CR_ADD;
      for i:= 0 to FDevises.Count-1 do TmDevice(FDevises[i]).Cursor:= CR_ADD;
     end;
    end;
  end;

  FPBox.Invalidate;
end;

procedure TmFloor.SetGridColor(c: TColor);
begin
	FGridColor:= c;
  FPBox.Invalidate;
end;

procedure TmFloor.SetGrid(b: boolean);
begin
	FGrid:= b;
  FPBox.Invalidate;
end;

procedure TmFloor.DrawGrid;
var
	i: integer;
  dx, dy: integer;
begin
	if not FGrid then Exit;

  FPBox.Canvas.Pen.Color:= FGridColor;

  dy:= FCellsY*FGridWidth;
	for i:= 0 to FCellsX do
  begin
    dx:= FGridWidth*i;
    FPBox.Canvas.MoveTo(dx, 0);
		FPBox.Canvas.LineTo(dx, dy);
  end;

  dx:= FCellsX*FGridWidth;
	for i:= 0 to FCellsY do
  begin
    dy:= FGridWidth*i;
    FPBox.Canvas.MoveTo(0, dy);
		FPBox.Canvas.LineTo(dx, dy);
  end;
end;

procedure TmFloor.PBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FEdit then//���� �� � ������ ����������, �� ������ � ������������
  	if Sender is TmDevice then
    	if FOperation in [mo_Switch5,	mo_Switch24, mo_Workstation, mo_Server] then Exit
			else DoOperation(x,y, TmDevice(Sender))
    else
			DoOperation(x,y)
  else//����� ����������
  	DrawUnderPoint(x,y);//��������� ��������� ��� ��������
end;

procedure TmFloor.PBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
begin
	if FParent=nil then Exit;
  HideInfo;
  if not FEdit then Exit;
  if ssLeft in Shift then DrawUnderPoint(x,y);
end;

procedure TmFloor.PBoxPaint(Sender: TObject);
var
	i,j: integer;
  dx, dy: integer;
  rect: TRect;
begin
  for i:=0 to FCellsX-1 do
  	for j:= 0 to FCellsY-1 do
    begin
			FPBox.Canvas.Pen.Width:= 1;
      FPBox.Canvas.Brush.Color:= FFloorColors[FField[i,j]];

      dx:= FGridWidth*i;
      dy:= FGridWidth*j;
      rect.Left:=	dx;
      rect.Top:=	dy;
      rect.Right:=	dx+FGridWidth;
      rect.Bottom:=	dy+FGridWidth;
      
      FPBox.Canvas.FillRect(Rect);
    end;
  DrawGrid;

  i:= 0;
  while i<FLines.Count do
  begin
    if TmLine(FLines[i]).Count=0 then
    begin
    	TmLine(FLines[i]).Free;
      FLines.Delete(i);
    end else
    begin
   		TmLine(FLines[i]).Draw;
      inc(i);
    end;
  end;
end;

procedure TmFloor.SetParent(p: TWinControl);
begin
	FPBox.Parent:= p;
  FParent:= p;
  if FParent<>nil then UpdateState;
end;

constructor TmFloor.Create(AOwner: TComponent);
begin
	inherited Create;
  FPBox:= TPaintBox.Create(AOwner);
  FPBox.Align:=				alClient;
  FPBox.OnPaint:=			PBoxPaint;
  FPBox.OnMouseDown:=	PBoxMouseDown;
  FPBox.OnMouseMove:=	PBoxMouseMove;

  FGridColor:=		DEF_GRIDCOLOR;
  FGridWidth:=		DEF_GRIDWIDTH;
  FFloorColors:=	DEF_COLORS;
  FloorName:=			DEF_FLOORNAME;

	FDevises:=	TList.Create;
  FLines:=		TList.Create;

  UpdateState;
end;

destructor TmFloor.Destroy;
begin
  Clear;
  FPBox.Destroy;
	SetLength(FField, 0, 0);
  FDevises.Free;
  FLines.Free;
  
  inherited Destroy;
end;

end.
