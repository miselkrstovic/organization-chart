program Example;

uses
  Forms,
  untMain in 'untMain.pas' {frmMain},
  OrganizationChart in '..\..\src\OrganizationChart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
