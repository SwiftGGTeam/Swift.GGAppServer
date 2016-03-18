# Swift.GGAppServer

The server side of offical Swift.GG Application, written in Swift.

<center>
  <img src="./logo_new.png" width ="180" alt="Logo"/>
</center>


## Intro

Current the swift version we use is `DEVELOPMENT-SNAPSHOT-2016-03-01-a`, it has already defined at `.swift-version` file in the source folder.

This project support running in teminal or Xcode, before running, you must install and config.

Sometime the config in OSX and Linux are a bit different, so we will **Seperate** them.

## OSX

1.Install swift

- Go to the [offical websit](https://swift.org/) to download and install the swift.
- [Swfitenv](https://github.com/kylef/swiftenv) is a better util to control different swift versions.

2.Install MySQL by [Homebrew](http://brew.sh/)

```sh
brew install mysql
```

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

Unfortunately, the mysql header file has some issue when Xcode to build and link, so now we modify it by hand.

```sh
cd /usr/local/include/mysql
```

find `client_plugin.h` at line `103` replace the include with ```#include "plugin_auth_common.h"```.

find `my_alloc.h` at line `27` replace the include code with ```#include "mysql/psi/psi_memory.h"```.

Now, Launch Xcode, run the blow shell in terminal to start Xcode with the new version of swift.

```sh
xcrun launch-with-toolchain /Library/Developer/Toolchains/swift-latest.xctoolchain
```

Next, see the source code, you will find a folder named **XcodeProject**, go in and double click the SwiftGGAppServer.xcodeproj to launch Xcode and now `cmd+r`, when it build success, everything is OK !

## Linux

## CLI

In the source folder, we write some shell script to help `build`, `clean`, `run`, `release` our **SwiftGGAppServer**.

## ToDo

- [x] make a new Xcode Cocoa Application, Support using the GUI to run the server on osx
- [x] make a fix shell to prefix the build problems
- [ ] Error Constants

## Feature

### User
- [x] Login
- [ ] Register
- [ ] Info

### Article
- [ ] CategoryList
- [ ] ArticleInfo
- [ ] Detail
- [ ] NewArticle
