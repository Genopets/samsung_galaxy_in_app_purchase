# Flutter Samsung Galaxy In-App Purchase Plugin

This Flutter plugin facilitates the integration of Samsung Galaxy In-App Purchase (IAP) SDK with your Flutter application, enabling seamless in-app purchase functionality for Samsung Galaxy devices. 

|             | Android |
|-------------|---------|
| **Support** | SDK 12+ |

## Some screens
<p>
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/example.gif?raw=true"
    alt="An animated image of the iOS in-app purchase UI" height="400"/>
</p>

<p>
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow1.jpeg?true"
    alt="" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow2.jpeg?true"
    alt="" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow3.jpeg?true"
    alt="" height="400"/>
</p>

<p>
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow4.jpeg?true"
    alt="" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow5.jpeg?true"
    alt="" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Genopets/samsung_galaxy_in_app_purchase/blob/master/doc/flow6.jpeg?true"
    alt="" height="400"/>
</p>
## Requirements step by step

1. Have your app almost ready to deploy (Mock IAP flow)
2. Samsung device
3. Device should be logged in with a Samsung Account (Device settings)
4. Create an account at the [Galaxy Store](https://seller.samsungapps.com/)
   - Create an app, fill in some necessary data
   - Upload an APK
   - Fill in IAP products
     - Your items should have similar id using your app's bundle identifier com.app.mobile.dev_item_xyz
5. Register licensed testers in [Galaxy Store Admin](https://seller.samsungapps.com/member/getSellerDetail.as)
6. Implement this package in your Flutter App and wire it
   - To test you should use an account added in step 5, and have IAP items with same bundle identifier step 4.

## How it works
We are using the [Samsung In-App Purchase SDK v6.1](https://developer.samsung.com/iap/release-note.html) in the background so from flutter side we can use channels to perform their IAP functionalities.

## Features
The following features are available

* Show galaxy in-app products that are available for sale from the galaxy store.
   Products can include Consumables, Non-Consumables and Subscription, although only Consumables were included in this first version. 
* Load in-app products that the user owns.
* Present the Galaxy UI for purchasing products.

### Step 1: Pubspec
Include this package in your ```pubspec.yaml```
```yaml
  samsung_galaxy_in_app_purchase: any
```

### Step 2: Root build.gradle
Use the ```:samsung_galaxy_in_app_purchase``` sdk within your root ```build.gradle```

```groovy
allprojects {
    repositories {
        ...
        flatDir {
            dirs 'libs'
            dirs project(':samsung_galaxy_in_app_purchase').file('libs')
        }
    }
}
```
### Step 3: Use it in your flutter app

To use the library, just create an instance of GalaxyIap and any of the available functions can be used.

```dart
  final galaxyIapPlugin = GalaxyIap();
  final await galaxyIapPlugin.getPurchasableItems();
  ...
```
## Resources
- https://seller.samsungapps.com/
- https://developer.samsung.com/iap
- https://developer.samsung.com/galaxy-store

