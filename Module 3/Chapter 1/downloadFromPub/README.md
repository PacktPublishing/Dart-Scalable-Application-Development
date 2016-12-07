##Download From Pub Script

This dart script was written as a quick and dirty fix for Dart issue 11877 which causes the 'pub get' command to fail on a Windows system

https://code.google.com/p/dart/issues/detail?id=11887

The application downloads the required package from pub.dartlang.org and unpacks it in you pub cache.

To use
* open a command shell and navigate to you dart project
* run the command **pub get**
* if it fails note the package name and version number of the package that could not be downloaded
* run this dart script with the package and version number as command line parameters
* run the command **pub get** again untill all packages are downloaded.

## Example

pub get fails with the following log, indicating the download of *matcher* version *1.10.0* failed
```
Downloading polymer_ui_elements 0.1.2...
Downloading polymer_elements 0.1.2+1...
Downloading matcher 0.10.0...
Rename failed, path = 'C:\Users\hangs_000\AppData\Roaming\Pub\Cache\_temp\dira7b91ac5-beff-11e3-beea-2016d87b1a0e' (OS Error: Access is denied.
, errno = 5)
```
to download the package run the following command 

**dart ..\downloadFromPub\bin\downloadfrompub.dart matcher 0.10.0** 

where ..\downloadFromPub\bin\ is your path to your copy of this script.


