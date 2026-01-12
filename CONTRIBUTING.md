# Contributing to Elastic

## Building from Source

Elastic requires Flutter and platform-specific dependencies to run. See the [Flutter documentation](https://docs.flutter.dev/get-started) for installation instructions.

Once Flutter is installed, download the package dependencies by running the command:
```bash
flutter pub get
```

For debug testing, build and run the app by running the command:
```bash
flutter run -d <PLATFORM>
```

For a release build, run the command:
```bash
flutter build <PLATFORM>
```
* The output executable will be located in:
    * Windows: `<PROJECT DIR>/build/windows/x64/runner/Release`
    * MacOS: `<PROJECT DIR>/build/macos/Build/Products/Release`
    * Linux: `<PROJECT DIR>/build/linux/x64/release/bundle`
    * Web: `<PROJECT DIR>/build/web`


## Running Unit Tests

Elastic uses the [Flutter unit test](https://docs.flutter.dev/testing/overview) framework and [Mockito](https://pub.dev/packages/mockito) for unit testing and creating mock classes.

To generate mock classes needed for tests, run the command:
```bash
dart run build_runner build
```

To execute all automated unit tests, run the command:
```bash
flutter test .
```
More information on the Flutter unit test framework can be located [here](https://docs.flutter.dev/testing/overview).

## Preparing a Pull Request

Thanks for contributing to Elastic! Before you should make a pull request, lets double check a few things.

> [!IMPORTANT]
> Remember that in order to make changes to Elastic, you must first fork this repository so you own a copy of this repository, make your changes on your fork, then open a pull request on this repository merging changes from your fork.

First, make sure that you pass all unit tests when you run:
```bash
flutter test .
```
Next, lets ensure that all files are properly formatted according to the Dart formatting style-guide by running (note: you must be in the root directory of the Elastic repository) :
```bash
dart format .
dart run import_sorter:main
```
Next, lets apply some automatic fixes by running:

```bash
dart fix --apply
```
However, this command can only fix some issues, and may not always show certain compiler or syntax errors. As such, we want to double check this, and we will run:
```bash
flutter analyze
```

If no issues are found, you are good to go, however if issues are found, it is important to address them.