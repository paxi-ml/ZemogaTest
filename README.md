# ZemogaTest
Test for Zamoga

This project uses Cocoapods, to install it please visit https://cocoapods.org and follow the installation instructions.
Because of Cocoapods you should open the .xcworkspace and not the .xcodeproj
Cocoapods is used only for Alamofire.

Offline mode
- For the offline mode we use Alamofire reachability to check if there's connection. We don't save all the data because the purpose is mainly showing I can use CoreData and Reachability so I consider there's no use in parsing all the data for a disposable project.

UI
- The UI is really basic, no special styling nor dark mode considerations were taken although in a real project we should follow a designers guideline and also use accesibility guidelines as flexible font sizing, dark mode considerations, localizations, etc. It was developed for iPhone because there was no special requirement for iPad, but I understand the conditionals to check if .pad or not, or even the use of specialized XIBs or storyboards.
