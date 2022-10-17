## Running the project
To install packages:
```sh
flutter pub get
```

The project uses multiple packages that depend on code generation (`mobx` and `freezed`), so the following command must also be run: (this version will run once and exit)
```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```
and this will listen for file changes: (useful for development)
```sh
flutter packages pub run build_runner watch --delete-conflicting-outputs
```
