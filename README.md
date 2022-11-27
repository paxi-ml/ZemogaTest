# ZemogaTest
Test for Zamoga

This project uses Cocoapods, to install it please visit https://cocoapods.org and follow the installation instructions.
Because of Cocoapods you should open the .xcworkspace and not the .xcodeproj
Cocoapods is used only for Alamofire.

Offline mode
- For the offline mode we use Alamofire reachability to check if there's connection. We don't save all the data because the purpose is mainly showing I can use CoreData and Reachability so I consider there's no use in parsing all the data for a disposable project.

UI
- The UI is really basic, no special styling nor dark mode considerations were taken although in a real project we should follow a designers guideline and also use accesibility guidelines as flexible font sizing, dark mode considerations, localizations, etc. It was developed for iPhone because there was no special requirement for iPad, but I understand the conditionals to check if .pad or not, or even the use of specialized XIBs or storyboards.

Unit Test
- Unit Test was just left as automatically set, because you asked for meaningful Unit Tests and honestly for me (and also according to theory) Unit Tests are used only for complex business logic, and this app currently has no calculations nor complex data processing. The main issues that I can think of, are all related to the API and that should be tested in the API itself. Some companies test it on both sides but checking for nils and data consistency of mock data seems useless. I would consider doing UI Testing for the sorting of the favorites and the clipping of the text, but honestly I don't believe much in mobile UI Testing because developers tend to to force the tests and make assumptions on the display of the elements rather than actual UI Testing, I could do it just for the purpose of the test but I consider the explanation to be enough and less of a waste of time.
