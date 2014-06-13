SwiftWeather
============

SwiftWeather is a small iOS app developed by Swift language.

##Screenshots
![Loading](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/loading-33.png)
![Swift Weather](https://raw.githubusercontent.com/JakeLin/SwiftWeather/master/screenshots/Swift-Weather-33.png)

## Used features
* Swift Programming Language
* Cocoapods
* AFNetworking
* Core Location

## Unknown issues
* Can not set font size for UILabel in Storyboard.
* Can not change the status bar's colour.


## How to build
Because the app uses CocoaPods, we need to run `pod install` to install all the pods.

1. Open Terminal app.
2. Change directory to the project folder. `cd $project_dir`
3. List all the file to check whether *Podfile* file is in the folder? `ls`
4. If the *Podfile* has been found, then execute `pod install`
5. If the Mac OS doesn't have CocoaPods installed. Please follow [CocoaPods Getting Started](http://guides.cocoapods.org/using/getting-started.html) to install.
6. Once complete installation, open *Swift Weather.xcworkspace* file with Xcode 6.
7. Press *Cmd + B* to build the app.
8. Press *Cmd + R* to run the app on Simulator.

## Credits
* Thanks to [johnsonjake](https://github.com/johnsonjake) for adding iOS 8 support and improving the UI/UX.
