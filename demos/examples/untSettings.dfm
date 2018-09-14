object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 217
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    491
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 45
    Top = 23
    Width = 103
    Height = 13
    Caption = 'Line Drawing Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 45
    Top = 119
    Width = 107
    Height = 13
    Caption = 'Deletion Behaviour'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object radZigzag: TRadioButton
    Left = 45
    Top = 50
    Width = 113
    Height = 17
    Caption = 'Zigzag line'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object radStraight: TRadioButton
    Left = 45
    Top = 73
    Width = 113
    Height = 17
    Caption = 'Straight line'
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 45
    Top = 144
    Width = 97
    Height = 17
    Caption = 'Abandon Mode'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 400
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    ModalResult = 8
    TabOrder = 3
  end
end
