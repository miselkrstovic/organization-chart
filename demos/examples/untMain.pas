{******************************************************************************}
{                                                                              }
{ Organization Chart                                                           }
{                                                                              }
{ The contents of this file are subject to the MIT License (the "License");    }
{ you may not use this file except in compliance with the License.             }
{ You may obtain a copy of the License at https://opensource.org/licenses/MIT  }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Unit owner:    Mišel Krstović                                                }
{ Last modified: Septermber 14, 2018                                           }
{                                                                              }
{******************************************************************************}

unit untMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Contnrs, Buttons, Math, ComCtrls, Grids, ValEdit, StdCtrls,
  JvExExtCtrls, JvComponent, JvPanel, JvExControls,
  JvColorBox, JvColorButton, Mask, JvExMask, JvToolEdit, JvSpin,
  OrganizationChart, Vcl.Tabs, Vcl.Menus;

type
  TfrmMain = class(TForm)
    popOrganizationChart: TPopupMenu;
    AddSiblingNode1: TMenuItem;
    AddChildNode1: TMenuItem;
    N1: TMenuItem;
    DeleteNode1: TMenuItem;
    N2: TMenuItem;
    Settings1: TMenuItem;
    N3: TMenuItem;
    ClearChart1: TMenuItem;
    pnlNodeOptions: TPanel;
    pnlNodeOptionsHeader: TPanel;
    edtTopicName: TEdit;
    cbxColor: TJvColorButton;
    spdNodeShapeRectangle: TSpeedButton;
    spdNodeShapeRoundRectangle: TSpeedButton;
    spdNodeShapeEllipse: TSpeedButton;
    spdNodeShapeCircle: TSpeedButton;
    spdNodeShapeSquare: TSpeedButton;
    spdNodeShapeDiamond: TSpeedButton;
    lblNodeCaption: TLabel;
    lblNodeShape: TLabel;
    lblNodeSize: TLabel;
    spnWidth: TJvSpinEdit;
    spnHeight: TJvSpinEdit;
    lblNodeColor: TLabel;
    cbxAlign: TComboBox;
    lblNodeAlignment: TLabel;
    edtCreatedDate: TJvDateEdit;
    Label1: TLabel;
    pnlNodeOptionsHide: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCreatedDateChange(Sender: TObject);
    procedure spnHeightChange(Sender: TObject);
    procedure spnWidthChange(Sender: TObject);
    procedure cbxColorChange(Sender: TObject);
    procedure edtTopicNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure AddSiblingNode1Click(Sender: TObject);
    procedure AddChildNode1Click(Sender: TObject);
    procedure DeleteNode1Click(Sender: TObject);
    procedure popOrganizationChartPopup(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure ClearChart1Click(Sender: TObject);
    procedure spdNodeShapeClick(Sender: TObject);
  private
    { Private declarations }
    procedure OrganizationChartOnChange(Sender: TObject);
    procedure InitOrganizationChart;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  OrganizationChart: TOrganizationChart;

implementation

{$R *.dfm}

uses untSettings;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  DoubleBuffered := true;
  InitOrganizationChart;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OrganizationChart.Free;
end;

procedure TfrmMain.ClearChart1Click(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to clear the whole chart?', mtWarning, mbYesNo, 0) = mrYes then begin
    OrganizationChart.Clear;
  end;
end;

procedure TfrmMain.edtTopicNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.TopicName := trim(edttopicname.Text);
  end;
end;

procedure TfrmMain.cbxColorChange(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then
    OrganizationChart.SelectedNode.NodeColor := cbxColor.Color;
end;

procedure TfrmMain.edtCreatedDateChange(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.CreationDate := edtCreatedDate.Date;
  end;
end;

procedure TfrmMain.spdNodeShapeClick(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    if spdNodeShapeRectangle.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsRectangle;
    end else if spdNodeShapeRoundRectangle.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsRoundRect;
    end else if spdNodeShapeEllipse.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsEllipse;
    end else if spdNodeShapeCircle.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsCircle;
    end else if spdNodeShapeSquare.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsSquare;
    end else if spdNodeShapeDiamond.Down then begin
      OrganizationChart.SelectedNode.NodeShape := TOrganizationNodeShapeType.nsDiamond;
    end;
  end;
end;

procedure TfrmMain.spnHeightChange(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.Height := trunc(spnHeight.Value);
  end;
end;

procedure TfrmMain.spnWidthChange(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.Width := trunc(spnWidth.Value);
  end;
end;

procedure TfrmMain.AddChildNode1Click(Sender: TObject);
begin
  OrganizationChart.AddChildNode(DEFAULT_TOPIC_NAME, nil);
end;

procedure TfrmMain.AddSiblingNode1Click(Sender: TObject);
begin
  OrganizationChart.AddNode(DEFAULT_TOPIC_NAME, nil);
end;

procedure TfrmMain.OrganizationChartOnChange(Sender: TObject);
begin
  pnlNodeOptionsHide.Visible := Sender = nil;

  if (Sender <> nil) then begin
    // Read node values and update editor with attributes
    // Attributes -> Topic name, Creation Date, Width, Height, Shape, Color, Align
    edtTopicName.Text := OrganizationChart.SelectedNode.TopicName;
    case OrganizationChart.SelectedNode.NodeShape of
      nsRectangle : spdNodeShapeRectangle.Down := True;
      nsRoundRect : spdNodeShapeRoundRectangle.Down := True;
      nsEllipse   : spdNodeShapeEllipse.Down := True;
      nsCircle    : spdNodeShapeCircle.Down := True;
      nsSquare    : spdNodeShapeSquare.Down := True;
      nsDiamond   : spdNodeShapeDiamond.Down := True;
    end;
    cbxColor.Color := OrganizationChart.SelectedNode.NodeColor;
    spnWidth.Value := OrganizationChart.SelectedNode.Width;
    spnHeight.Value := OrganizationChart.SelectedNode.Height;
    edtCreatedDate.Date := OrganizationChart.SelectedNode.CreationDate;
  end;
end;

procedure TfrmMain.popOrganizationChartPopup(Sender: TObject);
begin
  AddSiblingNode1.Enabled := False;
  AddChildNode1.Enabled := False;
  Deletenode1.Enabled := False;
  Settings1.Enabled := True;

  if Assigned(OrganizationChart) then begin
    AddSiblingNode1.Enabled := True;
    AddChildNode1.Enabled := True;

    if Assigned(OrganizationChart.SelectedNode) then begin
      if not(OrganizationChart.SelectedNode is TOrganizationRootNode) then begin
        Deletenode1.Enabled := True;
      end;
    end;
  end;
end;

procedure TfrmMain.Settings1Click(Sender: TObject);
var
  Dialog : TfrmSettings;
begin
  Dialog := TfrmSettings.Create(Self);

  // Update the settings with options from chart
  with Dialog do begin
    if OrganizationChart.LinkDrawType=ltStraight then begin
      Dialog.radStraight.Checked := true
    end else begin
      Dialog.radZigzag.Checked := true
    end;

    Dialog.cbxAbandonMode.Checked := OrganizationChart.Abandoner;

    Dialog.cbxSelectedColor.Color := OrganizationChart.SelectedNodeColor;
    Dialog.cbxBackgroundColor.Color := OrganizationChart.BackgroundColor;
  end;
  Dialog.ShowModal;

  // Update the chart with options from settings
  if Dialog.radStraight.Checked = true then begin
    OrganizationChart.LinkDrawType := ltStraight
  end else begin
    OrganizationChart.LinkDrawType := ltSquared;
  end;

  OrganizationChart.Abandoner := Dialog.cbxAbandonMode.Checked;

  OrganizationChart.SelectedNodeColor := Dialog.cbxSelectedColor.Color;
  OrganizationChart.BackgroundColor := Dialog.cbxBackgroundColor.Color;
end;

procedure TfrmMain.DeleteNode1Click(Sender: TObject);
begin
  OrganizationChart.DeleteNode;
end;

procedure TfrmMain.InitOrganizationChart;
begin
  if OrganizationChart = nil then begin
    OrganizationChart := TOrganizationChart.Create(frmMain);
    OrganizationChart.OnChange := OrganizationChartOnChange;

    PopupMenu := popOrganizationChart;
    pnlNodeOptions.BringToFront;
    pnlNodeOptionsHide.Align := alClient;

    spnHeight.MinValue := DEFAULT_NODE_HEIGHT;
    spnWidth.MinValue := DEFAULT_NODE_WIDTH;
    spnHeight.MaxValue := DEFAULT_NODE_HEIGHT_MAX;
    spnWidth.MaxValue := DEFAULT_NODE_WIDTH_MAX;
  end;
end;

initialization
  // Set form-global default formats
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FormatSettings.LongDateFormat := 'yyyy-mm-dd';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'hh:mm:ss';
  FormatSettings.LongTimeFormat := 'hh:mm:ss';
end.
