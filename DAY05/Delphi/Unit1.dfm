object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 895
  ClientWidth = 1240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    1240
    895)
  TextHeight = 15
  object Label1: TLabel
    Left = 648
    Top = 88
    Width = 23
    Height = 15
    Caption = 'Step'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 257
    Height = 23
    ItemIndex = 0
    TabOrder = 0
    Text = 'Example.txt'
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
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 1
    WordWrap = False
  end
  object Button1: TButton
    Left = 648
    Top = 47
    Width = 273
    Height = 25
    Caption = 'Find Location'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 648
    Top = 136
    Width = 273
    Height = 201
    TabOrder = 3
  end
  object Button2: TButton
    Left = 936
    Top = 47
    Width = 296
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Generate Maps'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Memo3: TMemo
    Left = 648
    Top = 360
    Width = 584
    Height = 516
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Memo4: TMemo
    Left = 936
    Top = 136
    Width = 296
    Height = 204
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    ExplicitWidth = 273
  end
  object eStep: TEdit
    Left = 683
    Top = 86
    Width = 549
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
end
