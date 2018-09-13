object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Organization Chart'
  ClientHeight = 600
  ClientWidth = 884
  Color = clWindow
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
    Top = 41
    Height = 559
    Align = alRight
    ExplicitLeft = 272
    ExplicitTop = 112
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnCreateChart: TSpeedButton
      Left = 8
      Top = 8
      Width = 97
      Height = 27
      Caption = 'Create Chart'
      OnClick = btnCreateChartClick
    end
    object btnClearChart: TSpeedButton
      Left = 111
      Top = 8
      Width = 91
      Height = 27
      Caption = 'Clear Chart'
      OnClick = btnClearChartClick
    end
  end
  object Panel2: TPanel
    Left = 681
    Top = 41
    Width = 203
    Height = 559
    Align = alRight
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
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
      Shape = bsTopLine
      ExplicitTop = 241
    end
    object Panel4: TPanel
      Left = 0
      Top = 156
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 96
        Top = 0
        Width = 107
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
        object cbxAlign: TComboBox
          Left = 0
          Top = 0
          Width = 107
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
      Left = 0
      Top = 104
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel7: TPanel
        Left = 96
        Top = 0
        Width = 107
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
        object cbxShape: TComboBox
          Left = 0
          Top = 0
          Width = 107
          Height = 21
          Align = alClient
          TabOrder = 0
          Text = 'stRectangle'
          OnClick = cbxShapeClick
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
      Left = 0
      Top = 78
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Panel10: TPanel
        Left = 96
        Top = 0
        Width = 107
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
          Width = 107
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
      Left = 0
      Top = 52
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Panel13: TPanel
        Left = 96
        Top = 0
        Width = 107
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
          Width = 107
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
      Left = 0
      Top = 26
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object Panel16: TPanel
        Left = 96
        Top = 0
        Width = 107
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
        object edtCreatedDate: TJvDateEdit
          Left = 0
          Top = 0
          Width = 107
          Height = 26
          Align = alClient
          ShowNullDate = False
          TabOrder = 0
          OnChange = edtCreatedDateChange
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
      Left = 0
      Top = 0
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object Panel19: TPanel
        Left = 96
        Top = 0
        Width = 107
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
        object edtTopicName: TEdit
          Left = 0
          Top = 0
          Width = 107
          Height = 26
          Align = alClient
          TabOrder = 0
          OnKeyUp = edtTopicNameKeyUp
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
      Left = 0
      Top = 130
      Width = 203
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object Panel25: TPanel
        Left = 96
        Top = 0
        Width = 107
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
        object cbxColor: TJvColorButton
          Left = 0
          Top = 0
          Width = 105
          Height = 26
          OtherCaption = '&Other...'
          Options = []
          Color = clWhite
          OnChange = cbxColorChange
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
  end
  object popOrganizationChart: TPopupMenu
    OnPopup = popOrganizationChartPopup
    Left = 24
    Top = 72
    object AddSiblingNode1: TMenuItem
      Caption = 'Add &sibling node'
      OnClick = AddSiblingNode1Click
    end
    object AddChildNode1: TMenuItem
      Caption = 'Add &child node'
      OnClick = AddChildNode1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object DeleteNode1: TMenuItem
      Caption = '&Delete node'
      OnClick = DeleteNode1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Settings1: TMenuItem
      Caption = 'Settin&gs'
      OnClick = Settings1Click
    end
  end
end
