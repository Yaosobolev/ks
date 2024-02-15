unit ufmInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfmInfo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInfo: TfmInfo;

implementation

{$R *.dfm}

procedure TfmInfo.FormActivate(Sender: TObject);
begin
  if Owner is TWinControl then  TWinControl(Owner).SetFocus;
end;

procedure TfmInfo.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	Visible:= FALSE;
end;

end.
