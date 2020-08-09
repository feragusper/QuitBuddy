# QuitBuddy

A Flutter application to control the cigarette problem.

![Detail](https://github.com/feragusper/QuitBuddy/workflows/Build/badge.svg)

Follow Us
---------
 - [Google Play] (https://play.google.com/store/apps/details?id=com.feragusper.QuitBuddy)

Support
-------
If you've found an error in this project, please file an issue: https://github.com/feragusper/QuitBuddy/issues

Patches are encouraged, and may be submitted by forking this project and submitting a pull request through GitHub.

Contribute
----------
Pull requests are welcome.

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

Build Configuration
-------------------
This project was build using Flutter

Release
-------

In order to make an Android release build:
 - Create a signature in android/buildsystem/key.jks
 - Create a properties file in andrid/buildsystem/key.properties with the values storePassword, keyPassword, keyAlias, storeFile
 - Change the version by modifying the version property in pubspec.yml (versionName+versionCode)
 - Run flutter build appbundle

In order to test web builds:
 - flutter run -d chrome --web-hostname localhost --web-port 7357

Architecture
------------
This project follows architecture guidelines that are based on [BLOC Sample] (https://github.com/brianegan/flutter_architecture_samples/tree/master/simple_bloc_flutter). 

Libraries and tools included
----------------------------
- RxDart
- BLOC
- Firestore
- Firebase Auth
- Google Sign In

Licensing
---------
Please see the file called LICENSE.
