unit uMyPanel;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls, WinApi.Messages, Vcl.StdCtrls, Winapi.Windows;

const
  Key = '#LicenseKey';

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

function HDDVolumeSeri(Surucu:char):  string;
var
  NotUsed           :  dWord;
  VolumeFlags       :  dWord;
  VolumeInfo        :  array[0..MAX_PATH] of char;
  VolumeSerialNumber:  dWord;
begin
  GetVolumeInformation(PChar(Surucu + ':\'),
                       VolumeInfo, SizeOf(VolumeInfo),
                       @VolumeSerialNumber, NotUsed,
                       VolumeFlags, nil, 0);
  Result := Format('%x', [VolumeSerialNumber]);
end;

Function ASCIIbirUstHex( HDDVol:String ):String;
Var
  Sayac : Integer;
begin
  Result := '';
  For Sayac := 1 to Length(HddVol) do begin
    Result := Result + Format('%d', [ Ord(HddVol[Sayac])+1 ]);
  end;
end;

Function SifiraTamamlayan( Anahtar: String ):String;
Var
  Sayac : Integer;
begin
  Result := '';
  For Sayac := 1 to Length(Anahtar) do begin
    Result := Result + Format('%d', [ 9 - StrToInt(Anahtar[Sayac]) ]);
  end;
end;

Function ProgramCalissin( Anahtar, Verilen:String):Boolean;
begin
   Result := Verilen = SifiraTamamlayan( Anahtar );
end;

procedure Register;
Var
  s, VKey : string;
  HDDVolume : string;
  ASCIIHex : string;
  ASCIIHexZero: string;
begin

   HDDVolume := HDDVolumeSeri   ('C');
   ASCIIHex := ASCIIbirUstHex  ( HDDVolume );
   ASCIIHexZero := SifiraTamamlayan( ASCIIHex );


   try
      if ProgramCalissin( Key, ASCIIHexZero ) then
//      if Key = '123456789' then
      begin
         RegisterComponents('Samples', [TMyPanel]);
      end;
   except
    on E: Exception do
    begin
      S := E.Message;
      raise Exception.Create('Hata: Lisans Süresi Sona Ermiş!');
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
