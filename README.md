Swift Weather
============
[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=562a9aac2492560100211378&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/562a9aac2492560100211378/build/latest)

SwiftWeather is an iOS weather app developed in Swift 2. The app has been actively upgrading to adopt the latest features of iOS and Swift language.

## Notices
The current version is working with Xcode Version 7. If you are using different Xcode version, please check out the previous versions. 

## Version 3
This version has been upgraded to support iOS 9 only using Swift 2.

There are two major version for the app released before.

* V1.0 - Support iOS 7+ using CocoaPods and AFNetworking. [README.v1.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v1.md) and [Release V1 - Using Cocoapods and AFNetworking](https://github.com/JakeLin/SwiftWeather/releases/tag/V1)
* V2.0 - Support iOS 8+ using Carthage, Alamofire and SwiftyJSON. [README.v2.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v2.md) and [Release V2.0](https://github.com/JakeLin/SwiftWeather/releases/tag/v2.0)
* V2.1 -  Support iOS 8+ using Alamofire and SwiftyJSON. This version has removed Carthage because some developers don't have a paid Apple iOS developer account and they have issues to build Carthage packages.


## Screenshots


## Features
* Swift Programming Language - fully upgraded to version 2
* Design driven development - [Sketch design file ](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/Design/SwiftWeather.sketch)

![Sketch design](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/SketchDesign.png)
 
* Custom UIView

![Custom UIView](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/Custom-UIView.png)

* `@IBDesignable` and `@IBInspectable` - Reusable UI components

![IBDesignable and IBInspectable](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/IBDesignable-IBInspectable.png)

* `UIStackView` 

![UIStackView](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/UIStackView.png)
 
* Size Classes - Support different devices with adpative layout

![Size Classes](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/UIStackView-with-Size-Classes.png)

* MVVM - Reactively update `ViewController` UI from `ViewModel`

* Protocal oriented programming - Still learning though and finding the best practise of that.

* Value based programming - Use imutable value anywhere.

* Icon fonts － Use [Weather Icons](https://erikflowers.github.io/weather-icons/)
 
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

* Core Location

## TODO
* App indexing like CoreSpotlight and `NSUserActivity`
* <s>Unit Tests</s>
* UI Tests
* Animations  

## How to build

1) Clone the repository

```bash
$ git clone https://github.com/JakeLin/SwiftWeather.git
```

2) Install pods

```bash
$ cd SwiftWeather
$ pod install
```

3) Open the workspace in Xcode

```bash
$ open "SwiftWeather.xcworkspace"
```

4) Sign up on [openweathermap.org/appid](http://openweathermap.org/appid) to get an appid

```bash
$ mkdir .access_tokens
$ echo "your-openweathermap-appid" > .access_tokens/openweathermap
```
*Please replace "your-openweathermap-appid" with your actual appid key.*
 
5) Compile and run the app in your simulator

6) If you don't see any data, please check "Simulator" -> "Debug" -> "Location" to change the location.

# Requirements

* Xcode 7
* iOS 9
