SwiftWeather
============

SwiftWeather is a small iOS app developed in Swift language.

## Screenshots
![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/loading-33.png)

![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/Swift-Weather-33.png)

## Notices
Because Apple keeps changing the Swift compiler, the current version can be compiled in Xcode 6 beta 6. I will update the code when Apple updates Xcode 6.
 
## Used features
* Swift Programming Language
* CocoaPods
* AFNetworking
* Core Location

## Unknown issues
* Can not set font size for UILabel in Storyboard. (Xcode 6 beta2)
* Can not change the status bar's colour. (Xcode 6 beta2)


## How to build
Because the app uses CocoaPods, we need to run `pod install` to install all the pods.

1. Open Terminal app.
2. Change directory to the project folder. `cd $project_dir`
3. List `ls` all the file to check whether *Podfile* file is in the folder? 
4. If the *Podfile* has been found, then execute `pod install`
5. If the Mac OS doesn't have CocoaPods installed. Please follow [CocoaPods Getting Started](http://guides.cocoapods.org/using/getting-started.html) to install.
6. Once complete installation, open *Swift Weather.xcworkspace* file with Xcode 6.
7. Press *Cmd + B* to build the app.
8. Press *Cmd + R* to run the app on Simulator.

## Credits
* Thanks to [johnsonjake](https://github.com/johnsonjake) for adding iOS 8 support and improving the UI/UX.
