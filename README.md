# Swift.GGAppServer

The server side of offical Swift.GG Application, written in Swift.

<img src="./logo_new.png" width ="180" alt="Logo" align=center />

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

4.Build

```sh
cd yourcodefolder
chmod +x build
./build
```

5.Run

```sh
.build/debug/SwiftGGAppServer
```

6.Xcode Support

```sh
xcrun launch-with-toolchain /Library/Developer/Toolchains/swift-latest.xctoolchain
```

Run the above shell in terminal to start Xcode with the new version of swift.

Next, see the source code, you will find a folder named **XcodeProject**, go in and double click the SwiftGGAppServer.xcodeproj to launch Xcode and now `cmd+r`, when it build success, everything is OK !

## Linux

## CLI

In the source folder, we write some shell script to help `build`, `clean`, `run`, `release` our **SwiftGGAppServer**.
