unit umAnimateLines;

interface

uses
  windows, Types, Classes, Graphics;

type
  TAmimateInfo = record
  	Color1,
    Color2: TColor;
    width: integer;
    Points: array of TPoint;
    Canvas: TCanvas;
    Speed: integer;
  end;

  TmAnimateLines = class(TThread)
  private
    { Private declarations }
  protected
  	F: boolean;

    procedure Execute; override;
    procedure DrawLine;
  public
		AnimateInfo: TAmimateInfo;
  end;

implementation

uses Math;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TmAnimateLines.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TmAnimateLines }

procedure TmAnimateLines.DrawLine;
var
	oldClr: TColor;
  oldWidth: integer;
begin
	oldClr:=		AnimateInfo.Canvas.Pen.Color;
  oldWidth:=	AnimateInfo.Canvas.Pen.Width;
  AnimateInfo.Canvas.Pen.Width:= AnimateInfo.width;
  if F then AnimateInfo.Canvas.Pen.Color:= AnimateInfo.Color1
  else AnimateInfo.Canvas.Pen.Color:= AnimateInfo.Color2;

  AnimateInfo.Canvas.Polyline(AnimateInfo.Points);

  AnimateInfo.Canvas.Pen.Width:= oldWidth;
  AnimateInfo.Canvas.Pen.Color:= oldClr;
end;

procedure TmAnimateLines.Execute;
begin
  { Place thread code here }
  while not Self.Terminated do
  begin
		F:= not F;
    try
    	Synchronize(DrawLine);
    except
    	Break;
    end;

  	Sleep(Max(1000-AnimateInfo.Speed, 0));
  end;
  //восстановить исходный цвет линии
  F:= TRUE;
  Synchronize(DrawLine);
  SetLength(AnimateInfo.Points, 0);
end;

end.
