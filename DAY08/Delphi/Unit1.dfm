object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 898
  ClientWidth = 1029
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    1029
    898)
  TextHeight = 15
  object Fichier: TLabel
    Left = 8
    Top = 3
    Width = 35
    Height = 15
    Caption = 'Fichier'
  end
  object Label1: TLabel
    Left = 808
    Top = 26
    Width = 54
    Height = 15
    Caption = 'Progress : '
  end
  object lblProgres: TLabel
    Left = 879
    Top = 26
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
    Width = 423
    Height = 500
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    WordWrap = False
    ExplicitWidth = 419
  end
  object Memo2: TMemo
    Left = 453
    Top = 53
    Width = 563
    Height = 515
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitLeft = 449
    ExplicitHeight = 514
  end
  object Button1: TButton
    Left = 480
    Top = 22
    Width = 137
    Height = 25
    Caption = 'Part1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 648
    Top = 22
    Width = 137
    Height = 25
    Caption = 'Part2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 304
    Top = 22
    Width = 137
    Height = 25
    Caption = 'Pause'
    TabOrder = 5
    OnClick = Button3Click
  end
  object mDirections: TMemo
    Left = 8
    Top = 576
    Width = 428
    Height = 301
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 6
    ExplicitWidth = 424
    ExplicitHeight = 300
  end
  object MKeys: TMemo
    Left = 453
    Top = 578
    Width = 563
    Height = 299
    Anchors = [akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 7
    ExplicitLeft = 449
    ExplicitTop = 577
  end
end
