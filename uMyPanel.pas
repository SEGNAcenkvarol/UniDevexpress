unit uMyPanel;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls, WinApi.Messages;

const
  Key = '123456789';

type

  TMyPanel = class(TPanel)
  private
    { Private declarations }
    FSubPanel: TPanel;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
      message WM_WINDOWPOSCHANGED;

  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
Var
  s, VKey : string;
begin

   VKey := '123456789';
   try
      if Key = '123456789' then
      begin
         RegisterComponents('Samples', [TMyPanel]);
      end;
   except
    on E: Exception do
    begin
      S := E.Message;
      raise Exception.Create('Hata: Lisans Süresi Sona Ermiþ!');
    end;

   end;

//  VKey := '123456789';
//
//  if Key = VKey then
//  begin
//    RegisterComponents('Samples', [TMyPanel]);
//  end else
//    abort;

end;

{ TMyPanel }
const
  FSubPanelHeight = 30;

constructor TMyPanel.Create(AOwner: TComponent);

begin
  inherited;


    FSubPanel := TPanel.Create(Self);
    FSubPanel.Parent := Self;
    FSubPanel.Width := Width;
    FSubPanel.Height := FSubPanelHeight;
    FSubPanel.Caption := 'Title';
    FSubPanel.Color := $00F4EBE2;
    FSubPanel.Font.Color := $00B68C59;
    Caption := '';
    ShowCaption := False;
    Height := 100;
    Color := $00F4EBE2;

end;

destructor TMyPanel.Destroy;
begin
  if Assigned(FSubPanel) then
    FSubPanel.Destroy;
  inherited;
end;

procedure TMyPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  FSubPanel.Width := Width;
end;

end.
