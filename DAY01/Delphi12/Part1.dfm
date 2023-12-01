object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 939
  ClientWidth = 1572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1572
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 185
  end
  object FileListBox1: TFileListBox
    Left = 0
    Top = 41
    Width = 217
    Height = 898
    Align = alLeft
    ItemHeight = 15
    TabOrder = 1
    OnDblClick = FileListBox1DblClick
    ExplicitLeft = -5
    ExplicitTop = 40
  end
  object Panel2: TPanel
    Left = 217
    Top = 41
    Width = 1355
    Height = 898
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 840
    ExplicitTop = 456
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Splitter1: TSplitter
      Left = 688
      Top = 1
      Width = 8
      Height = 896
      Align = alRight
      ExplicitLeft = 952
    end
    object PageControl1: TPageControl
      Left = 696
      Top = 1
      Width = 658
      Height = 896
      ActivePage = TabSheet1
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 694
      ExplicitTop = 6
      object TabSheet1: TTabSheet
        Caption = 'Part1'
        object Button1: TButton
          Left = 0
          Top = 0
          Width = 650
          Height = 25
          Align = alTop
          Caption = 'Go'
          TabOrder = 0
          OnClick = Button1Click
          ExplicitLeft = -16
          ExplicitTop = -1
        end
        object mp1: TMemo
          Left = 0
          Top = 25
          Width = 650
          Height = 553
          Align = alTop
          TabOrder = 1
          ExplicitLeft = 3
          ExplicitTop = 152
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Part2'
        ImageIndex = 1
        object Button2: TButton
          Left = 0
          Top = 0
          Width = 650
          Height = 25
          Align = alTop
          Caption = 'Go'
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 3
          ExplicitWidth = 75
        end
      end
    end
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 687
      Height = 896
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 3
      ExplicitTop = 6
    end
  end
end
