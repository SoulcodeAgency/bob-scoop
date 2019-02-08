# Changelog

## 3.3

* Add bob.config parameter `InstallWebConfigWebConfigPath` to define fixed location of Sitecore web.config file (and prevent download it from respective Nuget package)

## 3.2.1

* Remove documents generation

## 3.2

* Add database backup prefix to handle different source environments

## 3.1

* Add support for Sitecore 9

## 3.0

* Initial release on GH
* Support for Gitbook 3

## 2.8

* Introduce Unicorn support for `Sync-ScDatabases`
* Add `Install-Webconfig` to `Initialize-Environment` (aka `bump`)

## 2.7

* Added parameter  `AdditionalXdtFiles` to `Install-WebConfigByFolders`

## 2.6

* Fix invalid SSL certificates in Chrome 58

## 2.5

* Reduce massively the package size by changing the curl package

## 2.4

* Remove Update-ScDatabases.ps1 as this is not supported for Sc 8.2 and later
* Change default backup behaviour of Install-Sitecore to false. With this version `Initialize-Environment` (alias `bump`) and `Install-Sitecore` by default are not creating a backup before they do a clean install into the web root.
* Add Install-WebConfig to `Initialize-Environment` (alias `bump`)
* Improve log output for indexlist updated by Scrambler

## 2.3

* Added support for Dizzy 3.0 functionalities

## 2.2

* Updated the theme

## 2.1.2

* Fixed a problem with certificate installation when https was the first binding

## 2.1.1

* Added a meaningful error message for missing WebRootConnectionStringsPath setting

## 2.1

* Implemented updating connection strings during Install-Sitecore execution

## 2.0

* Added support for Bob 2.0

## 1.6.2

* Added a new function 'Set-ScActiveEnvironment' for environment impersonation.

## 1.6.1

* Removed Keith and Pester from Nuget package

## 1.6

* 'Enable-ScSite' now checks if the configured path is existing or can be created.
* Updated Bob config to 1.4 to fix 'Import-ScDatabases'.
* Updated Pester and Skip.

## 1.5

* `Import-ScDatabases` now resets the password of the "admin" user to "b"
* `bump` will no chat a lot more

## 1.4.1

* Enhanced output of `Install-ScSerilaizationPackage` in order to get log file in Lofty working

## 1.4

* `Import-ScDatabases` now ignores the web database by default
* Fix  `Install-ScDatabases` Analytics setup in Sitecore 8
* Fix `bump` when Dizzy is not installed

## 1.3.1

* Update Bob config to 1.2 in order to fix external console launch.

## 1.3

* Added `Update-Sitecore` and `Update-ScDatabases`
* Moved `Install-ScSerilaizationPackage` from Lofty to Scoop

## 1.2.1

* Fixed Analytics database for Sitecore 7.2 and lower in `Install-ScDatabases`

## 1.2

* When NuGet creadentials are not saved in the NuGet.config, Scoop will ask for
    them and add them to NuGet.config
* Added support for Sitecore 8 Analytics and Session database in `Install-ScDatabases`


## 1.1

* Added `Install-ScDatabases`
* Added `Sync-ScDatabases`
* `Enable-ScSite` will now configure database security
* Added `ImportDatabaseTempLocation` config key
* Added `Start/Stop-ScAppPool`


## 1.0

* Initial version
