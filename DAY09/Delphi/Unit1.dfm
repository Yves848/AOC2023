object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 748
  ClientWidth = 1065
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1065
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 1061
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 46
      Height = 21
      Caption = 'Fichier'
    end
    object cbFichier: TComboBox
      Left = 66
      Top = 5
      Width = 213
      Height = 29
      TabOrder = 0
      Text = 'cbFichier'
      OnChange = cbFichierChange
    end
    object btnPart2: TButton
      Left = 936
      Top = 0
      Width = 129
      Height = 51
      Align = alRight
      Caption = 'Part 2'
      TabOrder = 1
      ExplicitLeft = 932
    end
    object btnPart1: TButton
      Left = 807
      Top = 0
      Width = 129
      Height = 51
      Align = alRight
      Caption = 'Part 1'
      TabOrder = 2
      OnClick = btnPart1Click
      ExplicitLeft = 803
    end
  end
  object pnlmain: TPanel
    Left = 0
    Top = 51
    Width = 1065
    Height = 697
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlmain'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 1061
    ExplicitHeight = 696
    object Splitter1: TSplitter
      Left = 297
      Top = 0
      Width = 6
      Height = 697
      ExplicitLeft = 152
      ExplicitTop = 24
    end
    object Panel2: TPanel
      Left = 303
      Top = 0
      Width = 762
      Height = 697
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 758
      ExplicitHeight = 696
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 762
        Height = 473
        Align = alTop
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
      end
    end
    object mSource: TListBox
      Left = 0
      Top = 0
      Width = 297
      Height = 697
      Align = alLeft
      ItemHeight = 21
      TabOrder = 1
      ExplicitHeight = 696
    end
  end
end
