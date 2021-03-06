# Swift.GGAppServer

The server side of offical Swift.GG Application, written in Swift.

<center>
  <img src="./logo_new.png" width ="180" alt="Logo"/>
</center>


## Intro

Currently the swift version we use is `DEVELOPMENT-SNAPSHOT-2016-03-01-a`, it has already defined at `.swift-version` file in the source folder.

This project support running in teminal or Xcode, before running, you must install and config.

Sometime the config in OSX and Linux are a bit different, so we will **Seperate** them.

## OSX

1.Install swift

- Go to the [offical websit](https://swift.org/) to download and install the swift.
- [Swfitenv](https://github.com/kylef/swiftenv) is a better tool to control different swift versions.

2.Install MySQL by [Homebrew](http://brew.sh/)

```sh
brew install mysql
```

Now,The version is `v5.7.11`, but unfortunately, the mysql header files has some issue when Xcode to build and link, so we need modify them by hand.

```sh
cd /usr/local/include/mysql
```

- find `client_plugin.h` at line `103` replace the include with ```#include "plugin_auth_common.h"```.
- find `my_alloc.h` at line `27` replace the include code with ```#include "mysql/psi/psi_memory.h"```.

3.Clone Codes

```sh
git clone https://github.com/SwiftGGTeam/Swift.GGAppServer.git
```

4.Fix codes to support SPM
```
cd yourcodefolder
./fix
```

5.Build

```sh
cd yourcodefolder
./build
```

6.Run

```sh
.build/debug/SwiftGGAppServer
```

7.Xcode Support

<s>Now, Launch Xcode, run the blow shell in terminal to start Xcode with the new version of swift.
```sh
xcrun launch-with-toolchain /Library/Developer/Toolchains/swift-latest.xctoolchain
```
</s>

Because Xcode7.3 release, you can choose Swift SDK version at `Xcode->Preference->Components`.

![Xcode_Select_Swift_Version](xcode_select_swift_version.png)

Next, see the source code, you will find a folder named **XcodeProject**, go in and double click the SwiftGGAppServer.xcodeproj to launch Xcode and now `cmd+r`, when it build success, everything is OK !

## Linux

## CLI

In the source folder, we write some shell script to help `build`, `clean`, `run`, `release` our **SwiftGGAppServer**.

## ToDo

- [x] make a new Xcode Cocoa Application, Support using the GUI to run the server on osx
- [x] make a fix shell to prefix the build problems
- [x] Error Constants
- [x] add regular expression support,[Regex](https://github.com/crossroadlabs/Regex.git)
- [x] generate the radom number util
- [ ] because the depndency libraries are update so frequently and support different version of swift, so in next step i will remove them and contains their codes, the less depdency the less complie error.
- [ ] design a logo
- [ ] add dao layer
- [ ] make ORM framework
- [ ] add quick way to transform model(DTO) to json
- [ ] change the database to [PostgreSQL](http://www.postgresql.org)
- [ ] fix build error with swift development version `DEVELOPMENT-SNAPSHOT-2016-03-16-a`, because new feature of `Swift3`, the SwitJSON can't build successfully.
- [ ] change the XcodeProject generate by the command ```swift build -X```
- [ ] all the http request and response will be encrypt by AES or DES
- [ ] new [SPM](https://github.com/CoderAFI/SPM) powerful tool, so i think will use the WatchDog


## Feature

### User
- [x] Login
- [x] Register
- [x] Info
- [ ] login and registe use mobile and captcha, and return the token with expire time

### Article
- [x] CategoryList
- [x] ArticleInfo
- [ ] NewArticle

## Compatible
- [x] Support Vapor v0.3 in 2016.3.22, Vapor change the `Controller` to `ResourceController` and add default behavior.

## Problem

When use the `DEVELOPMENT-SNAPSHOT-2016-03-16-a` version, it seems that spm not support run swift build in terminal, so run below shell code to fix the problem.

```sh
sudo install_name_tool -add_rpath /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2016-03-16-a.xctoolchain/usr/lib/swift/macosx /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2016-03-16-a.xctoolchain/usr/bin/swift-build
```

But when I lanch the Xcode it always tell me `Failed to verify signature!`, so now the `DEVELOPMENT-SNAPSHOT-2016-03-16-a` version is a Bridge.

## Follow
- [Swift bugs](https://bugs.swift.org/projects/SR/issues/SR-685?filter=allopenissues)
- [Swift CI ](https://ci.swift.org)

## License
Swift.GGAppServer is released under the MIT license.
