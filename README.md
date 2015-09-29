Swift Weather
============

SwiftWeather is an iOS weather app developed in Swift 2. The app has been kept upgrading to use the latest features of iOS and Swift language.

## Notices
The current version is working with Xcode Version 7. If you are using different Xcode version, please check out the previous versions.

If you are working on Swift 2 and Xcode 7, please checkout [xcode7 branch](https://github.com/JakeLin/SwiftWeather/tree/xcode7).

## Version 2.1
This is version

There are two major version for the app released before.

* V1.0 - Support iOS 7+ using CocoaPods and AFNetworking. [README.v1.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v1.md) and [Release V1 - Using Cocoapods and AFNetworking](https://github.com/JakeLin/SwiftWeather/releases/tag/V1)
* V2.0 - Support iOS 8+ using Carthage, Alamofire and SwiftyJSON. [README.v2.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v2.md) and [Release V2.0](https://github.com/JakeLin/SwiftWeather/releases/tag/v2.0)
* V2.1 -  Support iOS 8+ using Alamofire and SwiftyJSON. This version has removed Carthage because some developers don't have a paid Apple iOS developer account and they have issues to build Carthage packages.


## Screenshots


## Features
* Swift Programming Language - fully upgraded to 2
* MVVM - Reactively update `ViewController` UI from `ViewModel`
* `@IBDesignable` and `@IBInspectable` - Reusable UI components
* Size Classes - Support different devices with adpative layout
* Protocal oriented programming - Still learning though and finding the best practise of that.
* Value based programming - Use imutable value anywhere.
* Icon fonts
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* Core Location

## TODO
* App indexing like CoreSpotlight ans `NSUserActivity`
* Unit Tests
* UI Tests
* Animations  

## How to build

1) Clone the repository

```
$ git clone https://github.com/JakeLin/SwiftWeather.git
$ cd SwiftWeather
```

2) Install pods

```
$ pod install
```

3) Open the workspace in Xcode

```
$ open "SwiftWeather.xcworkspace"
```

4) Compile and run the app in your simulator

# Requirements

* Xcode 7-* iOS 9
