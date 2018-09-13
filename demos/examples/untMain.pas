unit untMain;
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
{ Last modified: March 30, 2013                                                }
{                                                                              }
{ Todo:                                                                        }
{   Node width calculation                                                     }
{   Node height calculation                                                    }
{   Drag and drop support                                                      }
{   Fix bug with horizontal node alignment                                     }
{   Zooming in and out                                                         }
{   Loading and saving of the chart (Persistence as JSON object                }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Contnrs, Buttons, Math, ComCtrls, Grids, ValEdit, StdCtrls,
  JvExExtCtrls, JvComponent, JvPanel, JvExControls,
  JvColorBox, JvColorButton, Mask, JvExMask, JvToolEdit, JvSpin,
  OrganizationChart, Vcl.Tabs, Vcl.Menus;

type
  TfrmMain = class(TForm)
    btnCreateChart: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    edtTopicName: TEdit;
    cbxShape: TComboBox;
    cbxAlign: TComboBox;
    edtCreatedDate: TJvDateEdit;
    cbxColor: TJvColorButton;
    btnClearChart: TSpeedButton;
    spnWidth: TJvSpinEdit;
    spnHeight: TJvSpinEdit;
    Bevel1: TBevel;
    popOrganizationChart: TPopupMenu;
    AddSiblingNode1: TMenuItem;
    AddChildNode1: TMenuItem;
    N1: TMenuItem;
    DeleteNode1: TMenuItem;
    N2: TMenuItem;
    Settings1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCreatedDateChange(Sender: TObject);
    procedure spnHeightChange(Sender: TObject);
    procedure spnWidthChange(Sender: TObject);
    procedure btnClearChartClick(Sender: TObject);
    procedure cbxShapeClick(Sender: TObject);
    procedure cbxColorChange(Sender: TObject);
    procedure edtTopicNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnCreateChartClick(Sender: TObject);
    procedure AddSiblingNode1Click(Sender: TObject);
    procedure AddChildNode1Click(Sender: TObject);
    procedure DeleteNode1Click(Sender: TObject);
    procedure popOrganizationChartPopup(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
  private
    { Private declarations }
    procedure OrganizationChartOnClick(Sender: TObject);
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
  btnCreateChartClick(Sender);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OrganizationChart.Free;
end;

procedure TfrmMain.cbxShapeClick(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.NodeShape :=
      TOrganizationNodeShapeType(cbxShape.ItemIndex);
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

procedure TfrmMain.btnClearChartClick(Sender: TObject);
begin
  OrganizationChart.Clear;
end;

procedure TfrmMain.OrganizationChartOnClick(Sender: TObject);
begin
  // Read node values and update editor with attributes
  // Attributes -> Topic name, Creation Date, Width, Height, Shape, Color, Align
  edttopicname.Text := OrganizationChart.SelectedNode.TopicName;
  edtCreatedDate.Date := OrganizationChart.SelectedNode.CreationDate;
  cbxShape.ItemIndex := integer(OrganizationChart.SelectedNode.NodeShape);
  cbxColor.Color := OrganizationChart.SelectedNode.NodeColor;
  spnWidth.Value := OrganizationChart.SelectedNode.Width;
  spnHeight.Value := OrganizationChart.SelectedNode.Height;
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
  with Dialog do begin
    // Update the settings with options from chart
    if OrganizationChart.LinkDrawType=ltStraight then begin
      Dialog.radStraight.Checked := true
    end else begin
      Dialog.radZigzag.Checked := true
    end;

    Dialog.CheckBox1.Checked := OrganizationChart.Abandoner;
  end;
  Dialog.ShowModal;

  // Update the chart with options from settings
  if Dialog.radStraight.Checked = true then begin
    OrganizationChart.LinkDrawType := ltStraight
  end else begin
    OrganizationChart.LinkDrawType := ltSquared;
  end;

  OrganizationChart.Abandoner := Dialog.CheckBox1.Checked;

end;

procedure TfrmMain.DeleteNode1Click(Sender: TObject);
begin
  OrganizationChart.DeleteNode;
end;

procedure TfrmMain.btnCreateChartClick(Sender: TObject);
begin
  OrganizationChart := TOrganizationChart.Create(frmMain);
  OrganizationChart.OnClick := OrganizationChartOnClick;

  PopupMenu := popOrganizationChart;

  btnCreateChart.Enabled := False;

  spnHeight.MinValue := DEFAULT_NODE_HEIGHT;
  spnWidth.MinValue := DEFAULT_NODE_WIDTH;
  spnHeight.MaxValue := DEFAULT_NODE_HEIGHT_MAX;
  spnWidth.MaxValue := DEFAULT_NODE_WIDTH_MAX;
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
