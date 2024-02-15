program Lab1;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uLines in 'uLines.pas',
  umAnimateLines in 'umAnimateLines.pas',
  uDevise in 'uDevise.pas',
  uAdvDevises in 'uAdvDevises.pas',
  uCmn in 'uCmn.pas',
  uFloor in 'uFloor.pas',
  ufmFloor in 'ufmFloor.pas' {fmFloor},
  ufmInfo in 'ufmInfo.pas' {fmInfo},
  ufmList in 'ufmList.pas' {fmList},
  ufmAbout in 'ufmAbout.pas' {fmAbout},
  ufmPrice in 'ufmPrice.pas' {fmPrice},
  ufmCost in 'ufmCost.pas' {fmCost};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
