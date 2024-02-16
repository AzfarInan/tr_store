# tr_store

TR Store is a Flutter E-Commerce Dummy Project. Where user can see products and their details. User
can add products to cart and see the cart details. Products will be saved locally for offline usage.
Data will be shown from Local DB after getting data from API. User can refresh data from API
anytime by pulling down to refresh.

## Configuration:
- Flutter: 3.16.9
- Riverpod
- Clean Architecture



## Initial Setup
- Clone the repository from GitHub
- Check if your flutter version is **3.16.9**. If not either upgrade your flutter version using `flutter pub upgrade` or use `fvm` tool to manage multiple version
- If you are using fvm, run `fvm install 3.16.9` and wait for it to finish downloading. If you already have it installed just run the `fvm use 3.16.9`.
    - If you are in **VS Code** then:
        - Tap Command+Shift+P and search for Change SDK. Check if detecting `3.16.9`. If not got to `Preference: Open User Settings (JSON)` and add the following line:
            ```
            "dart.sdkPaths": [".fvm/flutter_sdk", "/Users/dinury/src/flutter/bin/cache/dart-sdk/bin"],

            "dart.flutterSdkPaths": ["/Users/dinury/fvm/versions", "/Users/dinury/src/flutter/bin"],

            // Remove .fvm files from search
            "search.exclude": {
                "**/.fvm": true
            },
            // Remove from file watching
            "files.watcherExclude": {
                "**/.fvm": true
            },
            ```
      Here change the `dart.sdkPaths` & `dart.flutterSdkPaths` with your path.
    - After ensuring correct sdk paths are added tap Command+Shift+P and search for `Flutter: Change SDK` find the appropriate version. In this case `Flutter SDK 3.16.9`. Tap on it.
    - Then tap Command+Shift+P again and search for `Developer: Reload Window`. Tap on it.
    - Then check if VS Code is showing correct SDK version or not by checking  `Flutter: Change SDK`
      It should show: `Flutter SDK 3.16.9 Current Setting`
    - You are good to go. Environment setup is done.
    - For windows and Android Studio, check FVM website
- Run `fvm flutter pub get`
- Everything should be good to go. But if for some reason you are facing issues, try running `fvm flutter clean` and then `fvm flutter pub get` again.