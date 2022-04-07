; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！

;
;
;
;
; 
#define MyAppName "ODOOPOS"
#define MyAppVersion "6.8"
#define MyAppPublisher "Imreser"
#define MyAppURL "http://www.Imreser.com.cn"
#define MyAppExeName "Store.exe"


[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (生成新的GUID，点击 工具|在IDE中生成GUID。)
AppId={{AD554886-42E6-4C3B-9359-EF9B1ADFFF40}


AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=D:\Program Files\Imreser\{#MyAppName}
DefaultGroupName=Imreser
AllowNoIcons=yes
;LicenseFile=D:\SourceFile\Source\ODOOPOS\License.txt
InfoBeforeFile=D:\SourceFile\Source\ODOOPOS\Readme.txt
InfoAfterFile=D:\SourceFile\Source\ODOOPOS\upgrade.txt  
OutputDir=D:\FileOK
OutputBaseFilename=ODOOPOS Setup V2
SetupIconFile=D:\SourceFile\Source\ODOOPOS\ico.ico
Compression=lzma
SolidCompression=yes
;WizardSmallImageFile=mysmallimage.bmp
;WizardImageFile=myimage.bmp



[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"
;Name: "english"; MessagesFile: "compiler:Languages\English.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files] 
Source: "D:\SourceFile\Source\ODOOPOS\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\SourceFile\Source\ODOOPOS\bin\Store\Store.exe"; DestDir: "{app}\bin\Store"; Flags: ignoreversion
Source: "D:\SourceFile\Source\ODOOPOS\Fonts\simhei.ttf"; DestDir: "{fonts}"; FontInstall: "黑体"; Flags: overwritereadonly uninsneveruninstall
Source: "D:\SourceFile\Source\ODOOPOS\Fonts\arial.ttf"; DestDir: "{fonts}"; FontInstall: "Arial Unicode MS"; Flags: overwritereadonly uninsneveruninstall


Source: "D:\SourceFile\Source\ODOOPOS\ODOOPOS.bak"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\0TAB.sql"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\初始化处理.sql"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\设置.sql"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\POSScript.sql"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;


Source: "D:\SourceFile\Source\ODOOPOS\Restore.bat"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\Execute.bat"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;
Source: "D:\SourceFile\Source\ODOOPOS\Restart.bat"; DestDir: {app}; Flags: IgnoreVersion deleteafterinstall;


[Icons]
Name: "{group}\ODOOPOS"; Filename: "{app}\bin\Store\{#MyAppExeName}"
;Name: "{group}\ODOOPOS\{#MyAppName}"; Filename: "{app}\bin\Store\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,Imreser}"; Filename: "{#MyAppURL}"
;Name: "{group}\ODOOPOS\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\ODOOPOS"; Filename: "{app}\bin\Store\{#MyAppExeName}"; Tasks: desktopicon
;Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\Store\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userdesktop}\ODOOPOS"; Filename: "{app}\bin\Store\Store.exe"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\bin\Store\{#MyAppExeName}"; Tasks: quicklaunchicon

[InstallDelete]   
Type: files; Name: "{app}\ODOOPOS.bak"
Type: files; Name: "{app}\0TAB.sql"
Type: files; Name: "{app}\初始化处理.sql"
Type: files; Name: "{app}\设置.sql"
Type: files; Name: "{app}\POSScript.sql"

Type: files; Name: "{app}\Restore.bat"
Type: files; Name: "{app}\Execute.bat"
Type: files; Name: "{app}\Restart.bat"



[Run]
;Filename: "{app}\BIN\Store\Store.exe"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent;

Filename: {app}\Restore.bat; Description: 还原数据库; Flags:PostInstall waituntilterminated HideWizard;  
Filename: {app}\Execute.bat; Description: 执行脚本; Flags:PostInstall waituntilterminated HideWizard;  
Filename: {app}\Restart.bat; Description: 重启服务; Flags:postinstall waituntilterminated HideWizard;   

Filename: "{app}\bin\Store\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent;



[Code]    
var
  ODOOPOSPage: TInputQueryWizardPage;
  StorePage: TInputQueryWizardPage; 
procedure InitializeWizard; 


begin

// 创建页面
ODOOPOSPage := CreateInputQueryPage(wpWelcome,
  '设置连接到数据库',
  '',                                  
  '注意：连接服务器中的“.”，可改为主机的IP地址，使用“命名实例”方式安装数据库，连接服务器中需要填“实例名称”');       

    // 添加项目 (False 表示不是密码编辑)
    ODOOPOSPage.Add('连接服务器:', False);
    ODOOPOSPage.Add('实例名称:', False);
    ODOOPOSPage.Add('数据库名称:', False);
    ODOOPOSPage.Add('ODBC DSN:', False);

    // 设置初始值 (可选)
    ODOOPOSPage.Values[0] := ExpandConstant('.\SQLExpress');
    ODOOPOSPage.Values[1] := ExpandConstant('SQLExpress');
    ODOOPOSPage.Values[2] := ExpandConstant('ODOOPOS');
    ODOOPOSPage.Values[3] := ExpandConstant('ODOOPOS');  


// 创建页面
StorePage := CreateInputQueryPage(wpWelcome, 
  '设置店铺信息',
  '',
  '填写下列信息，然后单击下一步');

    // 添加项目 (False 表示不是密码编辑)
    StorePage.Add('店铺号:', False);
    StorePage.Add('钱箱号:', False);


    // 设置初始值 (可选) 
    StorePage.Values[0] := ExpandConstant('');
    StorePage.Values[1] := ExpandConstant('1');

end;
 
function GetODOOPOSInfo(Param: String): String;
begin
  { Return a user value }
  { Could also be split into separate GetUserName and GetUserCompany functions }   
  
  if Param = '数据库服务器' then
    Result := ODOOPOSPage.Values[0]    
  else if Param = '实例名称' then
    Result := ODOOPOSPage.Values[1]
  else if Param = '数据库名称' then
    Result := ODOOPOSPage.Values[2]
  else if Param = 'ODBC DSN' then
    Result := ODOOPOSPage.Values[3]  
end;


function GetStoreInfo(Param: String): String;
begin
  { Return a user value }
  { Could also be split into separate GetUserName and GetUserCompany functions }
  if Param = '店铺号' then
    Result := StorePage.Values[0]
  else if Param = '钱箱号' then
    Result := StorePage.Values[1]
end;


procedure CurStepChanged (CurStep:TSetupStep);
begin
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + '@' + 'echo off' + #13#10, True);    
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -Q ' + '"' + 'exec sp_addlogin ' + #39 + 'RMISSYSTEM' + #39 + #44 + #39 + '3UR0ST8P' + #39 + '"', True); 
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -Q ' + '"' + 'exec sp_adduser ' + #39 + 'RMISSYSTEM' + #39 + '"', True); 
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -Q ' + '"' + 'exec sp_addsrvrolemember ' + #39 + 'RMISSYSTEM' + #39 + #44 + #39 + 'sysadmin' + #39 + '"', True); 
                                                                                              
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + '@' + 'echo 数据库还原' + #13#10, True);  
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + '@' + 'echo on' + #13#10, True);  
SaveStringToFile(ExpandConstant('{app}/Restore.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -Q ' + '"' + 'restore database ODOOPOS from disk=' + #39 + ExpandConstant('{app}') + '\ODOOPOS.bak' + #39 + ' with move ' + #39 + 'ODOOPOS' + #39 + ' to '  + #39 + ExpandConstant('{app}') + '\DATA\ODOOPOS.mdf' + #39#44 + ' move ' + #39 + 'ODOOPOS_log' + #39 + ' to ' + #39  + ExpandConstant('{app}') + '\DATA\ODOOPOS.ldf' + #39 +'"' +  #13#10, True);


SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + '@' + 'echo 执行脚本' + #13#10, True); 
SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + '@' + 'echo on' + #13#10, True);  
SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -d ODOOPOS -i "' + ExpandConstant('{app}') + '\0TAB.sql' + '"', True);
SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -d ODOOPOS -i "' + ExpandConstant('{app}') + '\初始化处理.sql' + '"', True);
SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -d ODOOPOS -i "' + ExpandConstant('{app}') + '\设置.sql' + '"', True);
SaveStringToFile(ExpandConstant('{app}/Execute.bat'), #13#10 + 'SQLCMD -S ' + ExpandConstant('{code:GetODOOPOSInfo|数据库服务器}') + ' -d ODOOPOS -i "' + ExpandConstant('{app}') + '\POSScript.sql' + '"', True);


SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + '@' + 'echo 重启数据库服务中,请稍候...' + #13#10, True);
SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + '@' + 'echo 修正部分数据库未按规范安装的问题，重启服务，以使新设置生效！' + #13#10, True);
SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + 'net '+ 'stop' + ' MSSQLSERVER', True); 
SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + 'net '+ 'start' + ' MSSQLSERVER', True);
SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + 'net '+ 'stop' + ' MSSQL$'+ ExpandConstant('{code:GetODOOPOSInfo|实例名称}') , True);
SaveStringToFile(ExpandConstant('{app}/Restart.bat'), #13#10 + 'net '+ 'start' + ' MSSQL$'+ ExpandConstant('{code:GetODOOPOSInfo|实例名称}') , True);    

//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + '@' + 'echo off' + #13#10, True); 
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'Del '+ '"' + ExpandConstant('{app}') + '\ODOOPOS.bak' + '"', True);
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'Del '+ '"' + ExpandConstant('{app}') + '\Customer.sql' + '"', True);
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'Del '+ '"' + ExpandConstant('{app}') + '\Restore.bat' + '"', True);         
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'Del '+ '"' + ExpandConstant('{app}') + '\Execute.bat' + '"', True);
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'Del '+ '"' + ExpandConstant('{app}') + '\Clear.bat' + '"', True);
//SaveStringToFile(ExpandConstant('{app}/Clear.bat'), #13#10 + 'exit' + #13#10, True);
end;

 
 

[Registry]

Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\REMOTESYSTEM\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\REMOTESYSTEM\SETTINGS; ValueName: DB; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: REPORTSDIR; ValueData: {app}\Reports; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: BRANCHCODE; ValueData: {code:GetStoreInfo|门店代码}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: TILLNO; ValueData: {code:GetStoreInfo|钱箱编号}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: ROOTDIR; ValueData: {app}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: MEDIA_PATH; ValueData: {app}\Graphics\Videos; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: DB; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: IMAGECACHE; ValueData: {app}\Image; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\Imreser\SYSTEM\COMPONENTS; ValueName: bin; ValueData: {app}\bin; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\Imreser\SYSTEM\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\Imreser\SYSTEM\SETTINGS; ValueName: DATABASE; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;





Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\REMOTESYSTEM\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\REMOTESYSTEM\SETTINGS; ValueName: DB; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: REPORTSDIR; ValueData: {app}\Reports; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: BRANCHCODE; ValueData: {code:GetStoreInfo|门店代码}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: TILLNO; ValueData: {code:GetStoreInfo|钱箱编号}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: ROOTDIR; ValueData: {app}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: MEDIA_PATH; ValueData: {app}\Graphics\Videos; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: DB; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\ODOOSYSTEM\ODOOPOS\SETTINGS; ValueName: IMAGECACHE; ValueData: {app}\Image; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\SYSTEM\COMPONENTS; ValueName: bin; ValueData: {app}\bin; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\SYSTEM\SETTINGS; ValueName: DSN; ValueData: {code:GetODOOPOSInfo|ODBC DSN}; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\Imreser\SYSTEM\SETTINGS; ValueName: DATABASE; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;




;-----建立ODOOPOS的ODBC连接！----
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData: SQL SERVER; ValueType: string;
;Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData: SQL SERVER; ValueType: string; 
 
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Driver; ValueData: C:\Windows\system32\SQLSRV32.dll; ValueType: string; 
;Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Driver; ValueData: C:\Windows\system32\sqlncli10.dll; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Description; ValueData: ODOOPOS; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Server; ValueData: {code:GetODOOPOSInfo|数据库服务器}; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: AnsiNPW; ValueData: No; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: LastUser; ValueData: RMISSYSTEM; ValueType: string;
Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Database; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;

Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData:SQL Server; ValueType: string;
;Root: HKLM; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData:SQL Server Native Client 10.0; ValueType: string;



Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData: SQL SERVER; ValueType: string;
;Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData: SQL SERVER; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Driver; ValueData: C:\Windows\system32\SQLSRV32.dll; ValueType: string;
;Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Driver; ValueData: C:\Windows\system32\sqlncli10.dll; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Description; ValueData: ODOOPOS; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Server; ValueData: {code:GetODOOPOSInfo|数据库服务器}; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: AnsiNPW; ValueData: No; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: LastUser; ValueData: RMISSYSTEM; ValueType: string;
Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\{code:GetODOOPOSInfo|ODBC DSN}; ValueName: Database; ValueData: {code:GetODOOPOSInfo|数据库名称}; ValueType: string;

Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData:SQL Server; ValueType: string;
;Root: HKLM64;Check: IsWin64; SubKey: SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources; ValueName: {code:GetODOOPOSInfo|ODBC DSN}; ValueData:SQL Server Native Client 10.0; ValueType: string;



;-----更改IE设置，以使Web运行正常！  ----------
Root: HKCU64;Check: IsWin64; SubKey: Software\Microsoft\Internet Explorer\New Windows; ValueName: PopupMgr; ValueData: no; ValueType: string;
Root: HKCU;SubKey: Software\Microsoft\Internet Explorer\New Windows; ValueName: PopupMgr; ValueData: no; ValueType: string;

;-----专用，更改IE设置，以使Web运行正常！  ----------
Root: HKCU64;Check: IsWin64; SubKey: Software\Microsoft\Internet Explorer\New Windows\Allow; ValueName:*.elian.com; ValueData:00 00; ValueType: binary;  
Root: HKCU64;Check: IsWin64; SubKey: Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData; ValueName:UserFilter; ValueData:41 1f 00 00 53 08 ad ba 01 00 00 00 2e 00 00 00 01 00 00 00 01 00 00 00 0c 00 00 00 65 55 1b f3 24 61 d0 01 01 00 00 00 08 00 61 00 6e 00 74 00 61 00 2e 00 63 00 6f 00 6d 00; ValueType: binary;
Root: HKCU64;Check: IsWin64; SubKey: Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\elian.com; ValueName:https; ValueData:00000002; ValueType: dword;
Root: HKCU64;Check: IsWin64; SubKey: Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\elian.com; ValueName:http; ValueData:00000002; ValueType: dword;
Root: HKCU;SubKey: Software\Microsoft\Internet Explorer\New Windows\Allow; ValueName:*.elian.com; ValueData:00 00; ValueType: binary;  
Root: HKCU;SubKey: Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData; ValueName:UserFilter; ValueData:41 1f 00 00 53 08 ad ba 01 00 00 00 2e 00 00 00 01 00 00 00 01 00 00 00 0c 00 00 00 65 55 1b f3 24 61 d0 01 01 00 00 00 08 00 61 00 6e 00 74 00 61 00 2e 00 63 00 6f 00 6d 00; ValueType: binary;    
Root: HKCU;SubKey: Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\elian.com; ValueName:https; ValueData:00000002; ValueType: dword;
Root: HKCU;SubKey: Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\elian.com; ValueName:http; ValueData:00000002; ValueType: dword;


;-----改变数据库登录验证模式为混合模式，配合安装包重启服务命令生效！ ----------
Root: HKLM64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;
;Root: HKLM64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;
;Root: HKLM64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;      
Root: HKLM;SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;   
;Root: HKLM;SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;
;Root: HKLM;SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer"; ValueName: LoginMode; ValueData: 00000002; ValueType: dword;      

;-----启用协议:TCP/IP、NamePipes，配合安装包重启服务命令生效！ ----------

Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\SuperSocketNetLib\Tcp";  ValueName: Enabled; ValueData: 00000001; ValueType: dword;
Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\SuperSocketNetLib\Np";  ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Tcp"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Np"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\SuperSocketNetLib\Tcp"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\SuperSocketNetLib\Np"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\SuperSocketNetLib\Tcp";  ValueName: Enabled; ValueData: 00000001; ValueType: dword;
Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\SuperSocketNetLib\Np";  ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Tcp"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Np"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\SuperSocketNetLib\Tcp"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\SuperSocketNetLib\Np"; ValueName: Enabled; ValueData: 00000001; ValueType: dword;



;-----启用“针对 Transact-SQL 访问启用 FILESTREAM”，配合安装包重启服务命令生效！ ----------
Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;
;Root: HKCU64;Check: IsWin64; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;
Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.{code:GetODOOPOSInfo|实例名称}\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;
;Root: HKLM; SubKey: "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10_50.Imreser\MSSQLServer\Filestream"; ValueName: EnableLevel; ValueData: 00000001; ValueType: dword;













