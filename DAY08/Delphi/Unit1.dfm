object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 774
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    1058
    774)
  TextHeight = 15
  object Fichier: TLabel
    Left = 8
    Top = 3
    Width = 35
    Height = 15
    Caption = 'Fichier'
  end
  object Label1: TLabel
    Left = 816
    Top = 60
    Width = 54
    Height = 15
    Caption = 'Progress : '
  end
  object lblProgres: TLabel
    Left = 871
    Top = 60
    Width = 130
    Height = 15
    AutoSize = False
  end
  object cbFichier: TComboBox
    Left = 8
    Top = 24
    Width = 257
    Height = 23
    TabOrder = 0
    Text = 'Example.txt'
    OnChange = cbFichierChange
    Items.Strings = (
      'Example.txt'
      'Example2.txt'
      'Example3.txt'
      'Data.txt')
  end
  object Memo1: TMemo
    Left = 8
    Top = 53
    Width = 457
    Height = 700
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 488
    Top = 96
    Width = 562
    Height = 657
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button1: TButton
    Left = 488
    Top = 56
    Width = 137
    Height = 25
    Caption = 'Part1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 656
    Top = 56
    Width = 137
    Height = 25
    Caption = 'Part2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 488
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Pause'
    TabOrder = 5
    OnClick = Button3Click
  end
end
