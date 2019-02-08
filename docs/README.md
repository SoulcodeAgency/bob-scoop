<div class="chapterlogo"><img src="./Scoop.jpg" /></div>

# Scoop

As with his front and rear shovels (scoops), Scoop provides a PSH based toolset for developers using Visual Studio.

Scoop is resposible for the following tasks.

* Configure IIS for the current Project
* Install sitecore
* Set serialization reference
* Import databases

Running all this tasks in a sequence can be done by running the following command in the "Package Manager Console"

    bump

## Install Scoop
Scoop can be installed by running the following command in the "Package Manager Console"

    Install-Package Unic.Bob.Scoop

## Settings

The following settings are relevant for Scoop.

| Key | Description | Example |
| --- | --- | --- |
| AppPoolRuntime | The runtime on which the application pool should run. Either `v4.0` or `v2.0` | `<AppPoolRuntime>v4.0</AppPoolRuntime>` |
| HostsFileComment | The comment to add on every line updated by Scoop in the hosts file. | `<HostsFileComment>inserted by bob</HostsFileComment>` |
| GlobalWebPath | An absolute path where the WebRoot and the backup folder are. | `<GlobalWebPath>D:\web</GlobalWebPath>` |
| WebsiteCodeName | The name of the IIS website and the folder in the `GlobalWebPath`.  | `<WebsiteCodeName>customer-internet</WebsiteCodeName>` |
| WebFolderName | A folder inside the `GlobalWebPath\WebsiteCodeName` which will be the WebRoot. | `<WebFolderName>Web</WebFolderName>` |
| InstallWebConfigWebConfigPath | Optional. A folder relative to the `ProjectPath` where the original Sitecore-Web.config is stored. If not present, original Sitecore-Web.config will be extracted from respective nuget package. | `<InstallWebConfigWebConfigPath>src\Project\Website\code</InstallWebConfigWebConfigPath>`
| BackupFolderName | A folder inside of `GlobalWebPath\WebsiteCodeName` where all backups are written to. | `<BackupFolderName>Backup</BackupFolderName>` |
| SerializationReferenceTemplate | A template for the serialization config file. | `<SerializationReferenceTemplate>`<br> `<![CDATA[` <br> `<configuration xmlns:patch="http://www.sitecore.net/xmlconfig/" xmlns:set="http://www.sitecore.net/xmlconfig/set/">` <br> `<sitecore>` <br> `<settings>` <br> `<setting name="SerializationFolder" set:value="" />` <br> `</settings>` <br> `</sitecore>` <br> `</configuration>` <br> `]]>` <br> `</SerializationReferenceTemplate>` |
| SerializationReferenceXPath | The xpath inside the serialization config to the serialization reference.  | `<SerializationReferenceXPath>configuration/sitecore/settings/setting/@set:value</SerializationReferenceXPath>`|
| SerializationPath | The path relative to the website project where the items should be serialized to. | `<SerializationPath>..\..\Serialization</SerializationPath>` |
| SerializationReferenceFilePath | The path inside the WebRoot of the serialization config. | `<SerializationReferenceFilePath>App_Config\Include\Unic.SerializationReference.config</SerializationReferenceFilePath>` |
| DatabaseServer | The server and instance of the Database. | `<DatabaseServer>localhost</DatabaseServer>` |
| DatabaseBackupShare | The file path where all database backups are. | `<DatabaseBackupShare>\\corp.unic.com\sys\backup\unic-dev-mssql2</DatabaseBackupShare>` |
| ConnectionStringsFolder | The path inside the Website to the connection strings config.  | `<ConnectionStringsFolder>App_Config\ConnectionStrings.config</ConnectionStringsFolder>` |
| UnmanagedFiles | A pattern of files which should be backed-up before reinstallation of Sitecore and restored after it. | `<UnmanagedFiles>` <br>  `App_Config\ConnectionStrings.config;` <br> `App_Config\Unmanaged\*` <br> `</UnmanagedFiles>` |
| IISBindings | A list of bindings to configure on the IIS. The IP parameter is optionally. | `<IISBindings>` <br> `<Binding IP="">http://dummy</Binding>` <br> `</IISBindings>` |
| IisAdminUser | If `IisAdminUser` is configured, this user will be granted access to the database. This should only be configured if you have a different default application pool user. | <IisAdminUser>NT Authority\Network Service</IisAdminUser> |
| ImportDatabaseTempLocation | A directory where the database backups are copied to before they are restored. If it's not specified `C:\temp` will be used. | `<ImportDatabaseTempLocation>D:\temp</ImportDatabaseTempLocation>` |
| PublishAfterDeserialization | When PublishAfterDeserialization is set to true, Scoop will perform a full publish after deserializing with `bump` or `Sync-ScDatabases`  | `<PublishAfterDeserialization>true</PublishAfterDeserialization>` |
| WebRootConnectionStringsPath | When WebRootConnectionStringsPath is set to a relative path to web root directory, Scoop will create connections strings in this directory after installing Sitecore with `Install-Sitecore`. They will be based on the connection strings values stored in the file specified in `ConnectionStringsFolder` setting. The server name will be taken from `DatabaseServer` setting. | `<WebRootConnectionStringsPath>App_Assets\content</WebRootConnectionStringsPath>` |
| ScoopPerformUnicornSync | Set the value of this setting to `1` to enable Unicorn sync in `Sync-ScDatabases`. If enabled, a configured `UnicornSharedSecret` must be present. Requires Unicorn 3.1 or newer. | `<ScoopPerformUnicornSync>1</ScoopPerformUnicornSync>` |
| UnicornSharedSecret | Taken from the Unicorn readme:<br> 1. "Generate a very long random shared secret key, preferably using a password generator. There are no limits on character count, character types, etc but it must be > 30 characters.<br> 2. Install the shared secret into the Unicorn.UI.config file - or a patch thereof, under the authenticationProvider/SharedSecret node. There are comments to help." | `<UnicornSharedSecret>you-secret-key</UnicornSharedSecret>` |

## Module development

Scoop can also be used in Modules. The installation is the same as for Websites. Make sure you configure the WebRoot key in Bob.config is set.

Currently `Set-ScSerializationReference` ist the only command suposed to be used in modules.

## SSL/TLS certificates
When configuring `IISBindings` with HTTPS, a certificate will be created
and configured automatically in `Enable-ScSite`. It will be signed with a
certificate authority named Scoop. The certificate authority will be created
automatically if it not exists yet and will be trusted in the windows
certificate store (e.g. for IE and Chrome) and the Firefox certificate store.  
