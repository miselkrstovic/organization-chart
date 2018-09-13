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
  OrganizationChart, Vcl.Tabs;

type
  TfrmMain = class(TForm)
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
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
    edttopicname: TEdit;
    cmbshape: TComboBox;
    ComboBox3: TComboBox;
    JvDateEdit1: TJvDateEdit;
    JvColorButton1: TJvColorButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    spnWidth: TJvSpinEdit;
    spnHeight: TJvSpinEdit;
    CheckBox1: TCheckBox;
    radZigzag: TRadioButton;
    radStraight: TRadioButton;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure DrawLinkTypeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure JvDateEdit1Change(Sender: TObject);
    procedure spnHeightChange(Sender: TObject);
    procedure spnWidthChange(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure cmbshapeClick(Sender: TObject);
    procedure JvColorButton1Change(Sender: TObject);
    procedure edttopicnameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
   OrganizationChart.Abandoner := CheckBox1.Checked;
end;

procedure TfrmMain.cmbshapeClick(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.NodeShape :=
      TOrganizationNodeShapeType(cmbshape.ItemIndex);
  end;
end;

procedure TfrmMain.edttopicnameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.TopicName := trim(edttopicname.Text);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OrganizationChart.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  DoubleBuffered := true;
  SpeedButton1Click(Sender);
end;

procedure TfrmMain.JvColorButton1Change(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then
    OrganizationChart.SelectedNode.NodeColor := JvColorButton1.Color;
end;

procedure TfrmMain.JvDateEdit1Change(Sender: TObject);
begin
  if OrganizationChart.SelectedNode <> nil then begin
    OrganizationChart.SelectedNode.CreationDate := JvDateEdit1.Date;
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

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  OrganizationChart.AddNode(DEFAULT_TOPIC_NAME, nil);
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  OrganizationChart.AddChildNode(DEFAULT_TOPIC_NAME, nil);
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
begin
  OrganizationChart.DeleteNode;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  OrganizationChart.Clear;
end;

procedure TfrmMain.OrganizationChartOnClick(Sender: TObject);
begin
  // Read node values and update editor with attributes
  // Attributes -> Topic name, Creation Date, Width, Height, Shape, Color, Align
  edttopicname.Text := OrganizationChart.SelectedNode.TopicName;
  JvDateEdit1.Date := OrganizationChart.SelectedNode.CreationDate;
  cmbshape.ItemIndex := integer(OrganizationChart.SelectedNode.NodeShape);
  JvColorButton1.Color := OrganizationChart.SelectedNode.NodeColor;
  spnWidth.Value := OrganizationChart.SelectedNode.Width;
  spnHeight.Value := OrganizationChart.SelectedNode.Height;
end;

procedure TfrmMain.DrawLinkTypeClick(Sender: TObject);
begin
  if radStraight.Checked = true then
    OrganizationChart.LinkDrawType := ltStraight
  else
    OrganizationChart.LinkDrawType := ltSquared;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  OrganizationChart := TOrganizationChart.Create(frmMain);
  OrganizationChart.Width := 800;
  OrganizationChart.Height := 600;
  OrganizationChart.OnClick := OrganizationChartOnClick;

  SpeedButton1.Enabled := false;
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
