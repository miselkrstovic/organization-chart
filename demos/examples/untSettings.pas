{******************************************************************************}
{                                                                              }
{ Organization Chart                                                           }
{                                                                              }
{ The contents of this file are subject to the MIT License (the "License");    }
{ you may not use this file except in compliance with the License.             }
{ You may obtain a copy of the License at https://opensource.org/licenses/MIT  }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Unit owner:    Mišel Krstović                                                }
{ Last modified: Septermber 14, 2018                                           }
{                                                                              }
{******************************************************************************}

unit untSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvColorBox,
  JvColorButton;

type
  TfrmSettings = class(TForm)
    Label1: TLabel;
    radZigzag: TRadioButton;
    radStraight: TRadioButton;
    cbxAbandonMode: TCheckBox;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    cbxSelectedColor: TJvColorButton;
    Label4: TLabel;
    cbxBackgroundColor: TJvColorButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

end.
