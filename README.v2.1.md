Swift Weather
============

SwiftWeather is an iOS weather app developed in Swift language. The app can support iPhone 4(s), iPhone 5(s), iPhone 6 and iPhone 6 Plus. The app also supports Today Widgets.

## Notices
The current version is working with Xcode Version 6.4 (6E35b). If you have any issue, please check the Xcode version. If there is still a problem with the supported versions, please raise an issue, thanks. 

## Version 2.1
This is version 2.1. I have removed Carthage because some developers don't have a paid Apple iOS developer account and they have issues to build Carthage packages. 

There are two major version for the app released before.

* V1.0 - Support iOS 7+ using CocoaPods and AFNetworking. [README.v1.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v1.md) and [Release V1 - Using Cocoapods and AFNetworking](https://github.com/JakeLin/SwiftWeather/releases/tag/V1)
* V2.0 - Support iOS 8+ using Carthage, Alamofire and SwiftyJSON. [README.v2.md](https://github.com/JakeLin/SwiftWeather/blob/master/README.v2.md) and [Release V2.0](https://github.com/JakeLin/SwiftWeather/releases/tag/v2.0)* 

V2.1 will be the last version support iOS 8. I am working on Xcode 7 to support iOS 9 only features like `UIStackView`. Happy coding.

## Screenshots
![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/loading-33.png)

![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/6-Today-smallsize.png)

![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/6-smallsize.png)

 
## Used features
* Swift Programming Language
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* Core Location
* Using Framework to share code between targets(app and widget).


## How to build

1) Download the repository

```
$ git clone https://github.com/JakeLin/SwiftWeather.git
$ cd SwiftWeather
```

2) Initialize submodule dependancies

```
$ git submodule update --init --recursive
```

3) Open the project in Xcode

```
$ open "Swift Weather.xcodeproj"
```

4) Compile and run the app in your simulator

# Requirements

- Xcode 6.4
- iOS 8

## Credits
* Thanks to [johnsonjake](https://github.com/johnsonjake) for adding iOS 8 support and improving the UI/UX.
* Thanks to [Marc](https://github.com/gizmou) for adding forcast feature, widget and app icon.
