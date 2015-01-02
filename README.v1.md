Swift Weather
============

SwiftWeather is an iOS weather app developed in Swift language. The app can support iPhone 4(s), iPhone 5(s), iPhone 6 and iPhone 6 Plus.

## Screenshots
![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/loading-33.png)

![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/6-Today-smallsize.png)


#### iPhone 4s
![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/4s-smallsize.png)

#### iPhone 5s
![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/5s-smallsize.png)


#### iPhone 6
![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/6-smallsize.png)


#### iPhone 6 Plus
![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/6plus-smallsize.png)

## Notices
Because Apple keeps changing the Swift compiler, the current version can be compiled in Xcode 6.1. 
 
## Used features
* Swift Programming Language
* CocoaPods
* AFNetworking
* Core Location


## How to build
Because the app uses CocoaPods, we need to run `pod install` to install all the pods.

1. Open Terminal app.
2. Change directory to the project folder. `cd $project_dir`
3. Use `ls` to list all the file to check whether *Podfile* file is in the folder? 
4. If the *Podfile* has been found, then execute `pod install`
5. If the Mac OS doesn't have CocoaPods installed. Please follow [CocoaPods Getting Started](http://guides.cocoapods.org/using/getting-started.html) to install.
6. Once complete installation, open *Swift Weather.xcworkspace* file with Xcode 6.
7. Press *Cmd + B* to build the app.
8. Press *Cmd + R* to run the app on Simulator.

## Credits
* Thanks to [johnsonjake](https://github.com/johnsonjake) for adding iOS 8 support and improving the UI/UX.
* Thanks to [Marc](https://github.com/gizmou) for adding forcast feature, widget and app icon.
