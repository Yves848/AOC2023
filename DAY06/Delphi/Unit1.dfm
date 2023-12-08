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
  TextHeight = 15
  object Fichier: TLabel
    Left = 8
    Top = 3
    Width = 35
    Height = 15
    Caption = 'Fichier'
  end
  object cbFichier: TComboBox
    Left = 8
    Top = 24
    Width = 257
    Height = 23
    ItemIndex = 0
    TabOrder = 0
    Text = 'Example.txt'
    OnChange = cbFichierChange
    Items.Strings = (
      'Example.txt'
      'Example2.txt'
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
  end
end
