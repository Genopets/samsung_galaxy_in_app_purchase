# Flutter Samsung Galaxy In-App Purchase Plugin

This Flutter plugin facilitates the integration of Samsung Galaxy In-App Purchase (IAP) SDK with your Flutter application, enabling seamless in-app purchase functionality for Samsung Galaxy devices. 

## How it works

To get started with integrating the Samsung Galaxy IAP SDK into your Flutter project, follow these steps:

### Step 1: Copy the Repository

Since this plugin was developed locally, it's essential to ensure that the source code is correctly placed within the project's base directory. This step involves copying the entire repository to the root of your project. After copying, you'll need to import the plugin into your project to utilize its functionalities.

```yaml
  galaxy_iap:
    path: ../../packages/galaxy_iap
```

### Step 2: Use library
To use the library, just create an instance of GalaxyIap and any of the available functions can be used.

```dart
  final _galaxyIapPlugin = GalaxyIap();
  final await _galaxyIapPlugin.getPurchasableItems();
```
### Important

Since the Samsung Galaxy IAP library is being imported locally, it is necessary to specify to our Maven where it should read the library from, it must point to the library repository in the path galaxy_iap/android/iap_sdk

```groovy
allprojects {
    repositories {
        // Other repositories...
        maven {
            url "$projectDir/../../../android/iap_sdk"
        }
    }
}
```

## How does it connect to the galaxy SDK

It's important to note that when working with plugins in Flutter, the behavior on the Android side is equivalent to that of an Android library. The files need to be compiled into a form that can be utilized. This means that directly using a source code library isn't feasible because Android libraries need to be compiled statically. Therefore, even if the source code is available, it must be converted into a format that can be compiled into the Android library.

In this case, there was a need to integrate a specific functionality provided by the Samsung Galaxy In-App Purchase (IAP) SDK. Since this functionality wasn't readily available as a Maven repository, additional steps were required to incorporate it into the project.

To achieve this, the source code of the Samsung Galaxy IAP SDK was obtained and converted into a format compatible with the Flutter project. This involved converting it into an .aar file, which is a package format for Android libraries.

Once the .aar file was obtained, it was published locally to the Maven repository. This allowed for managing the dependency within the project and accessing it during the build process. It was created inside the 'iap_sdk' folder in the root of the Android project.

To use a local Maven repository, it was necessary to specify in the build.gradle file the path where the published local Maven is located:
```groovy
allprojects {
    repositories {
        // Other repositories...
        maven {
            url "$projectDir/iap_sdk"
        }
    }
}
```

Finally, the library could be imported on the Android side:

```groovy
dependencies {
    // Other dependencies...
    implementation 'com.samsung.android.sdk.iap:genopets:1.0.0'
}
```