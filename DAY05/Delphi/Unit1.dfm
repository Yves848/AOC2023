object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 892
  ClientWidth = 1217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 257
    Height = 23
    TabOrder = 0
    Text = 'Exemple.txt'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Example.txt'
      'Data.txt')
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 617
    Height = 825
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    WordWrap = False
  end
  object Button1: TButton
    Left = 648
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 648
    Top = 136
    Width = 561
    Height = 201
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
  object Button2: TButton
    Left = 752
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Memo3: TMemo
    Left = 648
    Top = 360
    Width = 561
    Height = 513
    Lines.Strings = (
      'Memo3')
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
