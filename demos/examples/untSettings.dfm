object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 219
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
    219)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 21
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
    Left = 21
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
  object Label3: TLabel
    Left = 261
    Top = 87
    Width = 99
    Height = 13
    Caption = 'Background Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 261
    Top = 23
    Width = 81
    Height = 13
    Caption = 'Selected Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object radZigzag: TRadioButton
    Left = 21
    Top = 50
    Width = 113
    Height = 17
    Caption = 'Zigzag line'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object radStraight: TRadioButton
    Left = 21
    Top = 73
    Width = 113
    Height = 17
    Caption = 'Straight line'
    TabOrder = 1
  end
  object cbxAbandonMode: TCheckBox
    Left = 21
    Top = 144
    Width = 97
    Height = 17
    Caption = 'Abandon Mode'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 408
    Top = 186
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    ModalResult = 8
    TabOrder = 3
  end
  object cbxSelectedColor: TJvColorButton
    Left = 261
    Top = 42
    Width = 105
    Height = 26
    OtherCaption = '&Other...'
    Options = []
    Color = clWhite
    TabOrder = 4
    TabStop = False
  end
  object cbxBackgroundColor: TJvColorButton
    Left = 261
    Top = 106
    Width = 105
    Height = 26
    OtherCaption = '&Other...'
    Options = []
    Color = clWhite
    TabOrder = 5
    TabStop = False
  end
end
