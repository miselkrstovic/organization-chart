program Example;

uses
  Forms,
  untMain in 'untMain.pas' {frmMain},
  OrganizationChart in '..\..\src\OrganizationChart.pas' {$R *.res},
  untSettings in 'untSettings.pas' {frmSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.Run;
end.
