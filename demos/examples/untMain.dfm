object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Organization Chart'
  ClientHeight = 600
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 678
    Top = 0
    Height = 559
    Align = alRight
    ExplicitLeft = 272
    ExplicitTop = 112
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 559
    Width = 884
    Height = 41
    Align = alBottom
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 8
      Width = 73
      Height = 27
      Caption = 'Create Chart'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 87
      Top = 8
      Width = 78
      Height = 27
      Caption = 'Add Sibling'
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 171
      Top = 8
      Width = 87
      Height = 27
      Caption = 'Add Child'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 342
      Top = 8
      Width = 91
      Height = 27
      Caption = 'Delete Node'
      OnClick = SpeedButton4Click
    end
    object SpeedButton5: TSpeedButton
      Left = 439
      Top = 8
      Width = 91
      Height = 27
      Caption = 'Clear Chart'
      OnClick = SpeedButton5Click
    end
  end
  object Panel2: TPanel
    Left = 681
    Top = 0
    Width = 203
    Height = 559
    Align = alRight
    TabOrder = 1
    DesignSize = (
      203
      559)
    object Bevel1: TBevel
      Left = 6
      Top = 437
      Width = 187
      Height = 116
      Anchors = [akLeft, akRight, akBottom]
      ExplicitTop = 241
    end
    object Label1: TLabel
      Left = 14
      Top = 443
      Width = 106
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Line Drawing Type:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 247
    end
    object Panel4: TPanel
      Left = 1
      Top = 157
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object ComboBox3: TComboBox
          Left = 0
          Top = 0
          Width = 105
          Height = 21
          Align = alClient
          Color = clBtnFace
          Enabled = False
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Align'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 105
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel7: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object cmbshape: TComboBox
          Left = 0
          Top = 0
          Width = 105
          Height = 21
          Align = alClient
          TabOrder = 0
          Text = 'stRectangle'
          OnClick = cmbshapeClick
          Items.Strings = (
            #13'stRectangle'
            'stRoundRect'
            'stEllipse'
            'stCircle'
            'stSquare'
            'stDiamond')
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Shape'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel9: TPanel
      Left = 1
      Top = 79
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Panel10: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object spnHeight: TJvSpinEdit
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          Align = alClient
          AutoSize = False
          TabOrder = 0
          OnChange = spnHeightChange
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Height'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel12: TPanel
      Left = 1
      Top = 53
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Panel13: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object spnWidth: TJvSpinEdit
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          Align = alClient
          AutoSize = False
          TabOrder = 0
          OnChange = spnWidthChange
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Width'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel15: TPanel
      Left = 1
      Top = 27
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object Panel16: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object JvDateEdit1: TJvDateEdit
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          Align = alClient
          ShowNullDate = False
          TabOrder = 0
          OnChange = JvDateEdit1Change
          ExplicitHeight = 21
        end
      end
      object Panel17: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Created By'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel18: TPanel
      Left = 1
      Top = 1
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object Panel19: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object edttopicname: TEdit
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          Align = alClient
          TabOrder = 0
          OnKeyUp = edttopicnameKeyUp
          ExplicitHeight = 21
        end
      end
      object Panel20: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Topic Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel24: TPanel
      Left = 1
      Top = 131
      Width = 201
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object Panel25: TPanel
        Left = 96
        Top = 0
        Width = 105
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object JvColorButton1: TJvColorButton
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          OtherCaption = '&Other...'
          Options = []
          Color = clWhite
          OnChange = JvColorButton1Change
          TabOrder = 0
          TabStop = False
        end
      end
      object Panel26: TPanel
        Left = 0
        Top = 0
        Width = 96
        Height = 26
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object CheckBox1: TCheckBox
      Left = 14
      Top = 528
      Width = 97
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Abandon Mode'
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object radZigzag: TRadioButton
      Left = 14
      Top = 462
      Width = 113
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Zigzag line'
      Checked = True
      TabOrder = 8
      TabStop = True
      OnClick = DrawLinkTypeClick
    end
    object radStraight: TRadioButton
      Left = 14
      Top = 485
      Width = 113
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Straight line'
      TabOrder = 9
      OnClick = DrawLinkTypeClick
    end
  end
end
