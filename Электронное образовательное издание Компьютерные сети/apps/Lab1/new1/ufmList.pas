unit ufmList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls;

type
  TfmList = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FLBox: TCheckListBox;
    procedure SetCBox(c: TCheckListBox);
  public
    { Public declarations }
    property CBox: TCheckListBox write SetCBox;
  end;


implementation

{$R *.dfm}

procedure TfmList.SetCBox(c: TCheckListBox);
var
	i: integer;
begin
	CheckListBox1.Items.Assign(c.Items);
  for i:= 0 to c.Count-1 do
  	CheckListBox1.Checked[i]:= c.Checked[i];
	FLBox:= c;
end;

procedure TfmList.FormClose(Sender: TObject; var Action: TCloseAction);
var
	i: integer;
begin
	for i:= 0 to FLBox.Count-1 do
  	FLBox.Checked[i]:= CheckListBox1.Checked[i];
end;

end.
