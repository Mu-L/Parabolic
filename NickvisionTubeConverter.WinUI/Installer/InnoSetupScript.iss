; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Nickvision Parabolic"
#define MyAppShortName "Parabolic"
#define MyAppVersion "2023.12.0"
#define MyAppPublisher "Nickvision"
#define MyAppURL "https://nickvision.org"
#define MyAppExeName "NickvisionTubeConverter.WinUI.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F0AE5CF5-E5D8-45DA-BE26-292D04C2591B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
UsePreviousAppDir=no
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=..\..\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=..\Installer
OutputBaseFilename=NickvisionTubeConverterSetup
SetupIconFile=..\Resources\org.nickvision.tubeconverter.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
DirExistsWarning=no
CloseApplications=force
ChangesEnvironment=yes
AlwaysRestart=yes

[Code]
procedure SetupDotnet();
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\deps\dotnet-runtime-8-win-x64.exe'), '/install /quiet /norestart', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Unable to install .NET . Please try again', mbError, MB_OK);
end;

procedure SetupWinAppSDK();
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\deps\WindowsAppRuntimeInstall-x64.exe'), '--quiet', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Unable to install Windows App SDK. Please try again', mbError, MB_OK);
end;

procedure SetupPython();
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\deps\python-3.11.9-amd64.exe'), '/quiet InstallAllUsers=1 AppendPath=1 Include_test=0', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Unable to install Python. Please try again. THE APP WILL NOT FUNCTION CORRECTLY.', mbError, MB_OK)
  else begin
    if not Exec(ExpandConstant('C:\Program Files\Python311\pythonw.exe'), '-m pip install --force-reinstall "yt-dlp==2024.04.09"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
    then
      MsgBox('Unable to install yt-dlp. Please try again. THE APP WILL NOT FUNCTION CORRECTLY.', mbError, MB_OK)
  end;
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\..\dotnet-runtime-8-win-x64.exe"; DestDir: "{app}\deps"; AfterInstall: SetupDotnet  
Source: "..\..\..\WindowsAppRuntimeInstall-x64.exe"; DestDir: "{app}\deps"; AfterInstall: SetupWinAppSDK
Source: "..\..\..\python-3.11.9-amd64.exe"; DestDir: "{app}\deps"; AfterInstall: SetupPython  
Source: "..\bin\x64\Debug\net8.0-windows10.0.19041.0\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion 
Source: "..\bin\x64\Debug\net8.0-windows10.0.19041.0\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppShortName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppShortName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

