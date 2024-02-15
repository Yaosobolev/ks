object fmAbout: TfmAbout
  Left = 391
  Top = 282
  BorderIcons = []
  BorderStyle = bsNone
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 97
  ClientWidth = 180
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 180
    Height = 97
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 178
      Height = 95
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      OnMouseDown = Panel2MouseDown
      object Label1: TLabel
        Left = 40
        Top = 16
        Width = 110
        Height = 13
        Caption = #1055#1088#1086#1077#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1051#1042#1057
        OnMouseDown = Panel2MouseDown
      end
      object Label2: TLabel
        Left = 24
        Top = 40
        Width = 54
        Height = 13
        Caption = #1042#1099#1087#1086#1083#1085#1080#1083':'
        OnMouseDown = Panel2MouseDown
      end
      object Label3: TLabel
        Left = 40
        Top = 56
        Width = 114
        Height = 13
        Caption = #1089#1090#1091#1076#1077#1085#1090' '#1075#1088'. '#1047'-01-'#1055#1054#1042#1058
        OnMouseDown = Panel2MouseDown
      end
      object Label4: TLabel
        Left = 56
        Top = 72
        Width = 73
        Height = 13
        Caption = #1040#1075#1072#1092#1086#1085#1086#1074' '#1057'.'#1040'.'
        OnMouseDown = Panel2MouseDown
      end
    end
  end
end
