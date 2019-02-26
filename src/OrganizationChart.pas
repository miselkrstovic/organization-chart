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
{ The Original Code is OrganizationChart.pas.                                  }
{                                                                              }
{ Contains various graphics related classes and subroutines required for       }
{ creating a chart and its nodes, and visual chart interaction.                }
{                                                                              }
{ Unit owner:    Mišel Krstović                                                }
{ Last modified: September 13, 2018                                            }
{                                                                              }
{ Contributors:                                                                }
{   Altaf J. Basha                                                             }
{   Kareem Gendy                                                               }
{                                                                              }
{******************************************************************************}

unit OrganizationChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, Contnrs, Buttons, Math, ComCtrls, Grids, ValEdit, StdCtrls,
  JvExExtCtrls, JvComponent, JvPanel, JvOfficeColorPanel, JvExControls,
  JvColorBox, JvColorButton, Mask, JvExMask, JvToolEdit, JvSpin, Dialogs;

const
  DEFAULT_NODE_WIDTH  = 120;
  DEFAULT_NODE_HEIGHT = 70;
  DEFAULT_NODE_WIDTH_MAX  = 1024;
  DEFAULT_NODE_HEIGHT_MAX = 1024;
  DEFAULT_TOPIC_NAME  = 'New topic';

  crHandOpen  = 1;
  crHandClose = 2;

type
  TOrganizationNodeShapeType = (nsRectangle, nsRoundRect, nsEllipse, nsCircle, nsSquare, nsDiamond);
  TOrganizationNodeShapeAlignment = (saRight, saCenter, saLeft);
  TOrganizationNodeLinkDrawType = (ltSquared, ltStraight);

  TOrganizationNode = class(TShape)
  private
    _TopicName : WideString;
    _CreationDate : TDateTime;
    _NodeShape : TOrganizationNodeShapeType;
    _NodeColor : TColor;
    _NodeAlign : TOrganizationNodeShapeAlignment;
    _Displacement : Integer;
    _OnClick : TNotifyEvent;

    function _GetAlign: TOrganizationNodeShapeAlignment;
    function _GetColor: TColor;
    function _GetCreationDate: TDateTime;
    function _GetShape: TOrganizationNodeShapeType;
    function _GetTopicName: WideString;
    procedure _SetAlign(const Value: TOrganizationNodeShapeAlignment);
    procedure _SetColor(const Value: TColor);
    procedure _SetCreationDate(const Value: TDateTime);
    procedure _SetShape(const Value: TOrganizationNodeShapeType);
    procedure _SetTopicName(const Value: WideString);
    procedure _DrawTextBroadwise(Canvas: TCanvas; Width : Integer; Height : Integer); // Author: JVCL
  public
    IsCollapsed    : Boolean; // Todo: Node collapsing feature
    Children       : TObjectList;
    ParentNode     : TOrganizationNode;
    Data           : TObject;

    property OnNodeChange : TNotifyEvent read _OnClick write _OnClick;
    property TopicName : WideString read _GetTopicName write _SetTopicName;
    Property CreationDate : TDateTime  read _GetCreationDate write _SetCreationDate;
    property NodeShape : TOrganizationNodeShapeType read _GetShape write _SetShape;
    property NodeColor : TColor read _GetColor write _SetColor;
    property NodeAlign : TOrganizationNodeShapeAlignment Read _GetAlign write _SetAlign;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint(var Message: TWMChar); message WM_PAINT;
    function HasChildren : boolean;
    function IsAbandoner : boolean;
    procedure DoClick(Sender : Tobject);
    procedure DoMouseLeave(Sender : Tobject);
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

  TOrganizationRootNode = class(TOrganizationNode);

  TOrganizationChart = class(TPanel)
  private
    _ContainerBox     : TScrollBox;
    _OnClick          : TNotifyEvent;
    _DisplacementsMap : TStrings;
    _LinkDrawType     : TOrganizationNodeLinkDrawType;

    procedure SetLinkDrawType(const Value: TOrganizationNodeLinkDrawType);
    procedure FullStateChange( State : boolean; CurrentNode : TOrganizationNode);
    procedure RecursiveDraw(LevelY, LevelX : integer; var DisplacementsMap : TStrings; CurrentNode : TOrganizationNode);
    procedure ResetColor;
    procedure ResetColorEx(CurrentNode : TOrganizationNode);
    function displacement(CurrentNode : TOrganizationNode):Integer;
    procedure ClearNode(CurrentNode : TOrganizationNode);
    procedure DrawNodesLink(Point1, Point2 : TPoint; LinkType : TOrganizationNodeLinkDrawType = ltSquared);
    function MaxDisplacement(LevelY : Integer = 0) : integer;
  public
    Abandoner : boolean;
    Zoom      : boolean;
    Rotated   : boolean;
    Animated  : boolean;
    ThreeD    : boolean;
    IndentX   : integer;
    IndentY   : integer;
    LineWidth : integer;
    RootNode     : TOrganizationRootNode;
    SelectedNode : TOrganizationNode;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw;
    procedure Paint(var Message: TWMChar); message WM_PAINT;
    procedure FullExpand;
    procedure FullCollapse;
    procedure Clear;
    property LinkDrawType : TOrganizationNodeLinkDrawType read _LinkDrawType write SetLinkDrawType;
    property OnClick : TNotifyEvent read _OnClick write _OnClick;

    function AddNode(ATopicName : WideString; Ptr : TObject;
        AShape : TOrganizationNodeShapeType = nsRoundRect; AColor : TColor = clWhite;
        AWidth : Integer = DEFAULT_NODE_WIDTH; AHeight : Integer = DEFAULT_NODE_HEIGHT;
        AAlign : TOrganizationNodeShapeAlignment = saCenter) : TOrganizationNode;
    function AddChildNode(ATopicName : WideString; Ptr : TObject;
        AShape : TOrganizationNodeShapeType = nsRoundRect; AColor : TColor = clWhite;
        AWidth : Integer = DEFAULT_NODE_WIDTH; AHeight : Integer = DEFAULT_NODE_HEIGHT;
        AAlign : TOrganizationNodeShapeAlignment = saCenter) : TOrganizationNode;
    procedure RenameNode;
    procedure DeleteNode;
    procedure DoUpdateScrollBars;
    procedure DoNodeChange(Sender : TObject);
  end;

  TFontMetrics = class
  private
    ownerCanvas : TCanvas;
  public
    constructor Create(ACanvas : TCanvas);
    function stringWidth(Value : String): integer;
    function getHeight: integer;
    function getAscent(): integer;
  end;

implementation

{$R Cursors.res}

{ TOrganizationNode }

constructor TOrganizationNode.Create(AOwner: TComponent);
begin
  inherited;
  IsCollapsed  := false;
  TopicName    := DEFAULT_TOPIC_NAME;
  CreationDate := Now;
  Width        := DEFAULT_NODE_WIDTH;  // Which equals 90
  Height       := DEFAULT_NODE_HEIGHT; // Which equals 70
  NodeShape    := nsRectangle;
  NodeColor    := clWhite;
  NodeAlign    := saCenter;
  Children     := TObjectList.Create;
  OnClick      := DoClick;
  OnMouseDown  := DoMouseDown;
  OnMouseUp    := DoMouseUp;
  OnMouseLeave := DoMouseLeave;
  Data         := nil;
  Cursor       := crHandOpen;

  ParentNode   := nil;
end;

destructor TOrganizationNode.Destroy;
begin
  // Do not free the child nodes here..
  // ..there should be a mechanism to reallocate the child nodes to a
  // ..parent node.
  if Self.IsAbandoner then Self.Children.Clear;
  inherited;
end;

procedure TOrganizationNode.DoClick(Sender: Tobject);
begin
  TOrganizationChart(Self.Parent).ResetColor;
  TOrganizationChart(Self.Parent).SelectedNode := Self;
  Self.Brush.Color := clRed;

  if Assigned(OnClick) then _OnClick(Self);
end;

procedure TOrganizationNode.DoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Self.Cursor := crHandClose;
  Self.Parent.Perform(WM_SETCURSOR, Self.Parent.Handle, HTCLIENT);
end;

procedure TOrganizationNode.DoMouseLeave(Sender: Tobject);
begin
  ReleaseCapture;
  Self.Cursor := crHandOpen;
  Self.Parent.Perform(WM_SETCURSOR, Self.Parent.Handle, HTCLIENT);
end;

procedure TOrganizationNode.DoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Self.Cursor := crHandOpen;
  Self.Parent.Perform(WM_SETCURSOR, Self.Parent.Handle, HTCLIENT);
end;

function TOrganizationNode.HasChildren : boolean;
begin
  result := Children.Count > 0;
end;

function TOrganizationNode.IsAbandoner: boolean;
begin
  if Self.Parent<>nil then begin
    result := TOrganizationChart(Self.Parent).Abandoner;
  end else begin
    result := false;
  end;
end;

procedure TOrganizationNode._DrawTextBroadwise(Canvas: TCanvas; Width : Integer; Height : Integer);
const
  HFix = 4;
  YFix = 8;
var
  DrawPos, Pos1, Pos2, LineWidth, LineNo, LexemCount, TextHeight: Integer;
  Lexem: string;
  Size: TSize;
  LStop, LBroadwiseLine: Boolean;

  function GetNextLexem(var Pos1, Pos2: Integer; ATrimLeft: Boolean): string;
  var
    Pos: Integer;
  begin
    Pos := Pos1;
    if Caption[Pos] = ' ' then
      repeat
        Inc(Pos);
      until (Pos > Length(Caption)) or (Caption[Pos] <> ' ');
    Pos2 := Pos;
    if ATrimLeft and (LineNo > 0) then
      Pos1 := Pos;
    repeat
      Inc(Pos2);
    until (Pos2 > Length(Caption)) or (Caption[Pos2] = ' ');

    Result := Copy(Caption, Pos1, Pos2 - Pos1);
  end;

  procedure DrawLine(AdditSpace: Cardinal);
  var
    I, DrawPos1, DrawPos2: Integer;
    Lexem: string;
    Size: TSize;
    X, X1: Single;
  begin
    DrawPos1 := DrawPos;
    DrawPos2 := DrawPos;
    X := 0;
    X1 := 0;
    LineWidth := 0;
    for I := 1 to LexemCount do begin
      Lexem := GetNextLexem(DrawPos1, DrawPos2, I = 1);
      //      if LexemCount=1 then Lexem:=Lexem+' ';
      GetTextExtentPoint32(Canvas.Handle, PChar(Lexem), Length(Lexem), Size);
      Inc(LineWidth, Trunc(X));
      X := X + Size.cx;
      if (Trunc(X) > Width) and (LexemCount > 1) then Exit;

      if (LexemCount > 1) and LBroadwiseLine then
        X := X + AdditSpace / (LexemCount - 1);

      TextOut(Canvas.Handle, Trunc(X1) + HFix, LineNo * TextHeight + YFix, PChar(Lexem), Length(Lexem));
      X1 := X;
      DrawPos1 := DrawPos2;
    end;
  end;

begin
  if Text = '' then Exit;
  LineWidth := 0;
  LineNo := 0;
  DrawPos := 1;
  Pos1 := 1;
  Pos2 := 1;
  LexemCount := 0;
  TextHeight := 0;
  LStop := False;
  LBroadwiseLine := True;
  repeat
    Lexem := GetNextLexem(Pos1, Pos2, LexemCount = 0);
    //    if LexemCount=0 then Lexem:=Lexem+' ';
    GetTextExtentPoint32(Canvas.Handle, PChar(Lexem), Length(Lexem), Size);
    Inc(LineWidth, Size.cx);
    Inc(LexemCount);
    if TextHeight < Size.cy then
      TextHeight := Size.cy;
    if (LineWidth > Width) or (Pos2 >= Length(Caption)) then begin
      if LineWidth > Width then begin
        if LexemCount = 1 then
          Pos1 := Pos2;
        if LexemCount > 1 then
          Dec(LexemCount);
        DrawLine(Width - (LineWidth - Size.cx));
        DrawPos := Pos1;
        Inc(LineNo);
        LexemCount := 0;
        LineWidth := 0;
        LStop := Pos1 > Length(Caption);
      end else begin
        LBroadwiseLine := true; // ftoBroadwiseLastLine in Options;
        DrawLine(Width - LineWidth);
        Inc(LineNo);
        LStop := True;
      end;
    end else Pos1 := Pos2;
  until LStop;
//todo:  if FAutoSize then
//    Height := Max(12, LineNo * TextHeight);
end;

procedure TOrganizationNode.Paint(var Message: TWMChar);
var
  x, y      : integer;
  Points    : array of TPoint;
begin
  if NodeShape<>nsDiamond then begin
    inherited;
  end else begin
    SetLength(Points, 4);
    Points[0] := Point(0, Self.Height div 2);
    Points[1] := Point(Self.Width div 2,0);
    Points[2] := Point(self.Width, Self.Height div 2);
    Points[3] := Point(Self.Width div 2,Self.Height);

    self.Canvas.Brush.Color := self.Brush.Color;
    Self.Canvas.Polygon(Points);
  end;

  x := (Self.Width - Self.Canvas.TextWidth(TopicName)) div 2;
  y := (Self.Height - Self.Canvas.TextHeight(TopicName)) div 2;
  Self.Canvas.Font.Color := Self.Font.Color;

  Self.Text := TopicName;
  Self.Caption := TopicName;
  //  _DrawTextBroadwise(Self.Canvas, Self.Width - 8, Self.Height - 8);
end;

function TOrganizationNode._GetAlign: TOrganizationNodeShapeAlignment;
begin
  Result := _NodeAlign;
end;

function TOrganizationNode._GetColor: TColor;
begin
  result := _NodeColor;
end;

function TOrganizationNode._GetCreationDate: TDateTime;
begin
  Result := _CreationDate;
end;

function TOrganizationNode._GetShape: TOrganizationNodeShapeType;
begin
  Result := _NodeShape;
end;

function TOrganizationNode._GetTopicName: WideString;
begin
  Result := _TopicName;
end;

procedure TOrganizationNode._SetAlign(const Value: TOrganizationNodeShapeAlignment);
begin
  _NodeAlign := value;
end;

procedure TOrganizationNode._SetColor(const Value: TColor);
var
  Luminance,
  r, g, b : Integer;
begin
  _NodeColor := Value;
  Brush.Color := _NodeColor;

  // Adjust contrast using luminance
  b := (_NodeColor shr 16);
  g := (_NodeColor AND $0000FF00) shr 8;
  r := (_NodeColor AND $000000FF);
  Luminance := round(0.212671 * r + 0.715160 * g + 0.072169 * b);
  if Luminance > 60 then begin
    Self.Font.Color := clBlack;
  end else begin
    Self.Font.Color := clWhite;
  end;
end;

procedure TOrganizationNode._SetCreationDate(const Value: TDateTime);
begin
  _CreationDate := value;
end;

procedure TOrganizationNode._SetShape(const Value: TOrganizationNodeShapeType);
begin
  _NodeShape := Value;
  case _NodeShape of
    nsRectangle : Shape := stRectangle;
    nsRoundRect : Shape := stRoundRect;
    nsEllipse   : Shape := stEllipse;
    nsCircle    : shape := stCircle;
    nsSquare    : shape := stSquare;
    nsDiamond   : Shape := stCircle;
  end;
end;

procedure TOrganizationNode._SetTopicName(const Value: WideString);
var Temp : WideString;
begin
  Temp := Trim(Value);
  if Temp <> TopicName then begin
    _TopicName := Temp;
    Repaint;
  end;
end;

{ TOrganizationChart }

function TOrganizationChart.AddChildNode(ATopicName : WideString; Ptr : TObject;
        AShape : TOrganizationNodeShapeType = nsRoundRect; AColor : TColor = clWhite;
        AWidth : Integer = DEFAULT_NODE_WIDTH; AHeight : Integer = DEFAULT_NODE_HEIGHT;
        AAlign : TOrganizationNodeShapeAlignment = saCenter) : TOrganizationNode;
var
  ChildNode : TOrganizationNode;
begin
  result := nil;
  try
    ChildNode := TOrganizationNode.Create(Self);
    ChildNode.OnNodeChange := DoNodeChange;
    SelectedNode.Children.Add(ChildNode);
    ChildNode.ParentNode := SelectedNode;
    SelectedNode := ChildNode;

    SelectedNode.TopicName := ATopicName;
    SelectedNode.NodeShape := AShape;
    SelectedNode.NodeColor := AColor;
    SelectedNode.NodeAlign := AAlign;
    SelectedNode.Width     := AWidth;
    SelectedNode.Height    := AHeight;
    SelectedNode.Data      := Ptr;

    result := SelectedNode;
  finally
    Repaint;

    // Simulate a mouse click by sending the following messages
    SelectedNode.Perform(WM_LBUTTONDOWN, 0, 0);
    SelectedNode.Perform(WM_LBUTTONUP, 0, 0);
  end;
end;

function TOrganizationChart.AddNode(ATopicName : WideString; Ptr : TObject;
        AShape : TOrganizationNodeShapeType = nsRoundRect; AColor : TColor = clWhite;
        AWidth : Integer = DEFAULT_NODE_WIDTH; AHeight : Integer = DEFAULT_NODE_HEIGHT;
        AAlign : TOrganizationNodeShapeAlignment = saCenter) : TOrganizationNode;
var
  ChildNode : TOrganizationNode;
begin
  result := nil;
  try
    if (SelectedNode=RootNode) or (SelectedNode.ParentNode=RootNode) then begin
        ChildNode := TOrganizationNode.Create(self);
        ChildNode.OnNodeChange := DoNodeChange;
        RootNode.Children.Add(ChildNode);
        ChildNode.ParentNode := RootNode;
        SelectedNode := ChildNode;
    end else begin
        ChildNode := TOrganizationNode.Create(self);
        ChildNode.OnNodeChange := DoNodeChange;
        ChildNode.ParentNode := SelectedNode.ParentNode;
        SelectedNode.ParentNode.Children.Add(ChildNode);
        SelectedNode := ChildNode;
    end;

    SelectedNode.TopicName := ATopicName;
    SelectedNode.NodeShape := AShape;
    SelectedNode.NodeColor := AColor;
    SelectedNode.NodeAlign := AAlign;
    SelectedNode.Width      := AWidth;
    SelectedNode.Height     := AHeight;
    SelectedNode.Data       := Ptr;

    result := SelectedNode;
  finally
    Repaint;

    // Simulate a mouse click by sending the following messages
    SelectedNode.Perform(WM_LBUTTONDOWN, 0, 0);
    SelectedNode.Perform(WM_LBUTTONUP, 0, 0);
  end;
end;

procedure TOrganizationChart.Clear;
begin
  ClearNode(RootNode);
  Repaint;
end;

constructor TOrganizationChart.Create(AOwner: TComponent);
begin
  // Do not move the INHERITED statement above these three lines.
  _ContainerBox := TScrollBox.Create(AOwner);
  _ContainerBox.Align := alClient;
  if AOwner.InheritsFrom(TWinControl) then
    _ContainerBox.Parent := TWinControl(AOwner)
  else
    ShowMessage('TOrganizationChart create error!');
  AOwner := _ContainerBox;

  inherited;

  // Initialize class variables
  SelectedNode := nil;
  Zoom     := false;
  Rotated  := false;
  Animated := True;
  ThreeD   := true;

  // Initialize drawing parameters
  IndentX   := 25; // change  a 16 to 20
  IndentY   := 25; // change  a 16 to 20
  LineWidth := 1;

  // Create the root node
  RootNode := TOrganizationRootNode.Create(AOwner);
  SelectedNode := RootNode;

  _DisplacementsMap  := TStringList.Create;

  BevelInner := bvNone;
  BevelOuter := bvNone;
  BevelKind := bkNone;
  BorderStyle:= bsNone;
  Ctl3D := False;

  Align := alNone;

  if AOwner.InheritsFrom(TWinControl) then
    Parent := TWinControl(AOwner)
  else
    ShowMessage('TOrganizationChart create error!');
end;

procedure TOrganizationChart.DeleteNode;
var
  i, j : integer;
begin
   if SelectedNode<>RootNode then begin
      // Reallocate children to parentnode's children list
      if not(Abandoner) then begin
        if SelectedNode.HasChildren then begin
          for i := 0 to SelectedNode.Children.Count - 1 do begin
              TOrganizationNode(SelectedNode.Children[i]).ParentNode := SelectedNode.ParentNode;
          end;

          SelectedNode.ParentNode.Children.Assign(SelectedNode.Children,laOr);
        end;
      end;

      // Delete object from parents children list
      j := SelectedNode.ParentNode.Children.IndexOf(SelectedNode);
      if j<>-1 then begin
        SelectedNode.ParentNode.Children.Delete(j);
      end;

      SelectedNode := SelectedNode.ParentNode;
      Repaint;

      if SelectedNode.ParentNode<>nil then begin
        // Simulate a mouse click by sending the following messages
        SelectedNode.Perform(WM_LBUTTONDOWN, 0, 0);
        SelectedNode.Perform(WM_LBUTTONUP, 0, 0);
      end;
   end;
end;

destructor TOrganizationChart.Destroy;
begin
  Abandoner := false;
  RootNode.Free;

  inherited;
end;

procedure TOrganizationChart.RecursiveDraw(LevelY, LevelX : integer; var DisplacementsMap : TStrings; CurrentNode : TOrganizationNode);
var
  i  : integer;
  FixX, FixY : integer;
  Point1,
  Point2 : TPoint;
  temp     : integer;
begin
  inc(LevelY);
  if CurrentNode.HasChildren then begin
     for i := 0 to CurrentNode.Children.Count - 1 do begin
        Inc(LevelX);
        if TOrganizationNode(CurrentNode.Children[i]).Height=0 then begin
          TOrganizationNode(CurrentNode.Children[i]).Top := (LevelY * IndentY) + ((LevelY -1) * DEFAULT_NODE_HEIGHT);
        end else begin
          TOrganizationNode(CurrentNode.Children[i]).Top := (LevelY * IndentY) + ((LevelY -1) * TOrganizationNode(CurrentNode.Children[i]).Height);
        end;

        //----------------------------------------------------------------------
        // Calculate and update history of displacements
        if TOrganizationNode(CurrentNode.Children[i])._Displacement=0 then
            TOrganizationNode(CurrentNode.Children[i])._Displacement := TOrganizationNode(CurrentNode.Children[i]).Width + IndentX;

     //   if StrToIntDef(DisplacementsMap.Values[inttostr(LevelY)],0)=0 then begin
     //       TOrganizationNode(CurrentNode.Children[i]).Left :=TOrganizationNode(CurrentNode)._Displacement;// MaxDisplacement(LevelY-1) + (TOrganizationNode(CurrentNode.Children[i])._Displacement - TOrganizationNode(CurrentNode.Children[i]).Width) div 2;
     //   end else begin
            TOrganizationNode(CurrentNode.Children[i]).Left := StrToIntDef(DisplacementsMap.Values[inttostr(LevelY)],0) + (TOrganizationNode(CurrentNode.Children[i])._Displacement - TOrganizationNode(CurrentNode.Children[i]).Width) div 2;
    //    end;

        if DisplacementsMap.IndexOfName(inttostr(LevelY))<>-1 then begin
            // Found previous displacements in depth map
            DisplacementsMap.Values[inttostr(LevelY)] := IntToStr(StrToIntDef(DisplacementsMap.Values[inttostr(LevelY)],0) + TOrganizationNode(CurrentNode.Children[i])._Displacement);
        end else begin
            // No previous displacements in depth map
            DisplacementsMap.Add(inttostr(LevelY)+'='+IntToStr(TOrganizationNode(CurrentNode.Children[i])._Displacement));
        end;

//        writeln(TOrganizationNode(CurrentNode.Children[i])._TopicName, ' Dis=',TOrganizationNode(CurrentNode.Children[i])._Displacement, ' DisMap=',StrToIntDef(DisplacementsMap.Values[inttostr(LevelY)],0),', NodeW=',TOrganizationNode(CurrentNode.Children[i]).Width+IndentX,', MaxDis=',MaxDisplacement,', MaxDisLevelY=',MaxDisplacement(LevelY),', "',TOrganizationNode(CurrentNode.Children[i])._TopicName,'"');
        //----------------------------------------------------------------------
        
        TOrganizationNode(CurrentNode.Children[i]).Parent := Self;

        if (CurrentNode.ParentNode<>nil) then begin
            if CurrentNode.Width=0  then FixX := DEFAULT_NODE_WIDTH else FixX := CurrentNode.Width;
            if CurrentNode.Height=0 then FixY := DEFAULT_NODE_HEIGHT else FixY := CurrentNode.Height;

            //Point1 := Point(CurrentNode.Left + FixX div 2, CurrentNode.Top + FixY div 2);
            Point1 := Point(CurrentNode.Left + FixX div 2, CurrentNode.Top + FixY);
        end else begin
            Point1 := Point(Self.Width div 2 + 6, 0);
        end;

        Point2.X := TOrganizationNode(CurrentNode.Children[i]).Left  + (TOrganizationNode(CurrentNode.Children[i]).Width div 2 );
        Point2.Y := TOrganizationNode(CurrentNode.Children[i]).Top - 1;

        RecursiveDraw(LevelY, LevelX, DisplacementsMap, TOrganizationNode(CurrentNode.Children[i]));
        DrawNodesLink(Point1, Point2, _LinkDrawType);
     end;
     LevelX := 0;
  end;
  dec(LevelY);
end;

procedure TOrganizationChart.DoNodeChange(Sender: TObject);
begin
  if Assigned(_OnClick) then OnClick(Sender);
end;

procedure TOrganizationChart.DoUpdateScrollBars;
var
  i : integer;
  Size : TPoint;
begin
  Size := Point(100, 100);

  // Calculating the scrollbars
  for i := 0 to Self.ControlCount - 1 do begin
    if (Self.Controls[i] is TOrganizationNode) then begin
      Size.X := max(Size.X, (Self.Controls[i].Left + Self.Controls[i].Width));
      Size.Y := max(Size.Y, (Self.Controls[i].Top  + Self.Controls[i].Height));
    end;
  end;

  // Updating the container's width and height, only difference is detected
  if Self.Width <> Size.X then Self.Width := Size.X;
  if Self.Height <> Size.Y then Self.Height := Size.Y;
end;

procedure TOrganizationChart.Draw;
begin
  _DisplacementsMap.Clear; // Clear up the map data
  displacement(RootNode); // Calculate the child-parent displacement values
  RecursiveDraw(0, 0, _DisplacementsMap, RootNode); // Draw the graph
end;

procedure TOrganizationChart.DrawNodesLink(Point1, Point2: TPoint; LinkType : TOrganizationNodeLinkDrawType = ltSquared);
var
  Points : array of TPoint;
  Angle : Extended;
  RightAngle,
  LeftAngle : Extended;
const
  LineAngle  = 16;
  LineLength =  6;
begin
  // Attention: All calculations are in DEGREES and are NOT in radians!!
  // ---------------------------------------------------------------
  Self.Canvas.Brush.Color := Self.Canvas.Pen.Color;
  Self.Canvas.Pen.Color := Self.Canvas.Pen.Color;
  case LinkType of
    ltStraight : begin
      SetLength(Points, 3);

      // Draw the line
      Self.Canvas.PenPos := Point1;
      Self.Canvas.LineTo(Point2.X, Point2.Y);

      // Draw the arrow
      Points[0] := Point2;

      Angle := RadToDeg(ArcTan2((Point2.Y-Point1.Y), (Point2.X-Point1.X))); // Angle created with the horizon

//      if (Point2.X - Point1.X)<0 then angle := -1 * angle - 180;
      LeftAngle := Angle - LineAngle;
      RightAngle := Angle + LineAngle;

      Points[1].X := round(Point2.X + (-1) * LineLength * cos(DegToRad(LeftAngle)));
      Points[1].Y := round(Point2.Y + (-1) * LineLength * sin(DegToRad(LeftAngle)));
      Points[2].X := round(Point2.X + (-1) * LineLength * cos(DegToRad(RightAngle)));
      Points[2].Y := round(Point2.Y + (-1) * LineLength * sin(DegToRad(RightAngle)));
      Self.Canvas.PenPos := Point1;
      Self.Canvas.Polygon(Points);
    end;
    ltSquared : begin
      SetLength(Points, 4);

      // Draw the line
      Points[0] := Point1;
      Points[1] := Point(Point1.X, Point1.y + abs(Point2.Y - Point1.Y) Div 2);
      Points[2] := Point(Point2.X, Point1.y + abs(Point2.Y - Point1.Y) Div 2);
      Points[3] := point2;
      Self.Canvas.Polyline(Points);

      // Draw the arrow
      Self.Canvas.PenPos := Point2;
      Self.Canvas.Polygon([Point2, Point(Point2.X-2, Point2.Y-6), Point(Point2.X+2, Point2.Y-6)]);
    end;
  end;
end;

procedure TOrganizationChart.FullCollapse;
begin
  FullStateChange(true, RootNode);
  Repaint;
end;

procedure TOrganizationChart.FullExpand;
begin
  FullStateChange(False, RootNode);
  Repaint;
end;

procedure TOrganizationChart.FullStateChange(State: boolean; CurrentNode : TOrganizationNode);
var
  i : integer;
begin
  CurrentNode.IsCollapsed := State;
  if CurrentNode.HasChildren then begin
    for i := 0 to CurrentNode.Children.Count - 1 do begin
      FullStateChange(State, TOrganizationNode(CurrentNode.Children[i]));
    end;
  end;
end;

function TOrganizationChart.MaxDisplacement(LevelY : Integer = 0): integer;
var
  i : integer;
begin
  result := 0;
  for i := LevelY to _DisplacementsMap.Count do begin
    result := max(result, StrToIntDef(_DisplacementsMap.Values[inttostr(i)],0));
  end;
end;

procedure TOrganizationChart.ResetColorEx(CurrentNode : TOrganizationNode);
var
  i : integer;
begin
  if CurrentNode.HasChildren then begin
    for i := 0 to CurrentNode.Children.Count - 1 do begin
      TOrganizationNode(CurrentNode.Children[i]).Brush.Color := TOrganizationNode(CurrentNode.Children[i]).NodeColor;
      ResetColorEx(TOrganizationNode(CurrentNode.Children[i]));
    end;
  end;
end;

procedure TOrganizationChart.SetLinkDrawType(const Value: TOrganizationNodeLinkDrawType);
begin
  _LinkDrawType := Value;
  Repaint;
end;

Function TOrganizationChart.displacement(CurrentNode : TOrganizationNode): Integer;
var
  i : integer;
begin
  CurrentNode._Displacement := 0;
  if CurrentNode.HasChildren then begin
    for i := 0 to CurrentNode.Children.Count - 1 do begin
      CurrentNode._Displacement := CurrentNode._Displacement + displacement(TOrganizationNode(CurrentNode.Children[i]));
    end;

    result := CurrentNode._Displacement;
  end else begin
    result := CurrentNode.Width + IndentX;
  end;  
end;

procedure TOrganizationChart.ClearNode(CurrentNode : TOrganizationNode);
var
  i : integer;
begin
  if CurrentNode.HasChildren then begin
    for i := 0 to CurrentNode.Children.Count - 1 do begin
      ClearNode(TOrganizationNode(CurrentNode.Children[i]));
    end;

    CurrentNode.Children.Clear;
    SelectedNode := CurrentNode;
  end;
end;

procedure TOrganizationChart.ResetColor;
begin
  ResetColorEx(RootNode);
end;

procedure TOrganizationChart.Paint(var Message: TWMChar);
begin
  inherited;
  try
    Draw;
    DoUpdateScrollBars;
  finally
    Message.Result := 0;
  end;
end;

procedure TOrganizationChart.RenameNode;
var
  Temp : WideString;
begin
  if SelectedNode<>nil then begin
    Temp := SelectedNode.TopicName;
    InputBox('Organization Chart Node Renaming', 'Enter new name', SelectedNode.TopicName);

    // Only repaint if the TopicName has changed
    if Temp<>SelectedNode.TopicName then Repaint;
  end;
end;

{ TFontMetrics }

constructor TFontMetrics.Create(ACanvas: TCanvas);
begin
  ownercanvas := ACanvas;
end;
function TFontMetrics.getAscent: integer;
begin
  result := 0;
end;

function TFontMetrics.getHeight: integer;
begin
  result := ownerCanvas.TextHeight('Jp');
end;

function TFontMetrics.stringWidth(Value: String): integer;
begin
  result := ownerCanvas.TextWidth(Value);
end;

initialization
  Screen.Cursors[crHandOpen]  := LoadCursor(hInstance, 'HANDOPEN');
  Screen.Cursors[crHandClose] := LoadCursor(hInstance, 'HANDCLOSE');
end.
