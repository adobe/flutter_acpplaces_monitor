# flutter_acpplaces_monitor

[![pub package](https://img.shields.io/pub/v/flutter_acpplaces_monitor.svg)](https://pub.dartlang.org/packages/flutter_acpplaces_monitor) ![Build](https://github.com/adobe/flutter_acpplaces_monitor/workflows/Dart%20Unit%20Tests%20+%20Android%20Build%20+%20iOS%20Build/badge.svg) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

`flutter_acpplaces_monitor` is a flutter plugin for the iOS and Android [AEP Places Monitor SDK](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/adobe-places) to allow for integration with flutter applications. Functionality to enable the PlacesMonitor extension is provided entirely through Dart documented below.

## Installation

Add `flutter_acpcore`, `flutter_acppplaces` and `flutter_acpplaces_monitor` to your dependencies in `pubspec.yaml`

```yaml
dependencies:
  flutter_acpcore: ">= 1.0.0"
  flutter_acpplaces: ">= 1.0.0"
  flutter_acpplaces_monitor: ">= 1.0.0"
```

Then fetch the packages with:

```bash
flutter pub get
```

## Tests

Run:

```bash
flutter test
```

## Usage

### [PlacesMonitor](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/adobe-places)

##### Importing the SDK:
```dart
import 'package:flutter_acpplaces_monitor/flutter_acpplaces_monitor.dart';
```

##### Getting the SDK version:
 ```dart
String version = FlutterACPPlacesMonitor.extensionVersion;
 ```

 ##### Registering the extension with ACPCore:

 > Note: It is required to initialize the SDK via native code inside your AppDelegate and MainApplication for iOS and Android respectively. For more information see how to initialize [Core](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk#2-add-initialization-code).

 ##### **iOS**
 ```objective-c
#import "ACPCore.h"
#import "ACPPlaces.h"
#import "ACPPlacesMonitor.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    [ACPCore configureWithAppId:@"yourAppId"];
    [ACPPlaces registerExtension]; //Register Places with Core
    [ACPPlacesMonitor registerExtension]; //Register PlacesMonitor with Core
    [ACPCore start: nil];

    return YES;
}
 ```
 The following updates are also neccessary for Places Monitor on iOS:

- [Enable location updates in the background](https://docs.adobe.com/content/help/en/places/using/places-ext-aep-sdks/places-monitor-extension/using-places-monitor-extension.html#enable-location-updates-background)
- [Add the keys NSLocationWhenInUseUsageDescription and NSLocationAlwaysAndWhenInUseUsageDescription to the app's plist file](https://docs.adobe.com/content/help/en/places/using/places-ext-aep-sdks/places-monitor-extension/using-places-monitor-extension.html#configuring-the-plist-keys)


 ##### **Android:**
 Within the App's OnCreate method, register the SDK extensions and start the Places Monitor:
```java
import com.adobe.marketing.mobile.MobileCore;
import com.adobe.marketing.mobile.Places;
import com.adobe.marketing.mobile.PlacesMonitor;

public class MobileApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        MobileCore.setApplication(this);
        MobileCore.ConfigureWithAppId("yourAppId");
        try {
            Places.registerExtension(); //Register Places with Core
            PlacesMonitor.registerExtension(); //Register PlacesMonitor with Core
            MobileCore.start(null);
        } catch (Exception e) {
            //Log the exception
        }
    }
}
```
The following update is also necessary for Places Monitor on Android:

- [Add location permissions to the app manifest](https://docs.adobe.com/content/help/en/places/using/places-ext-aep-sdks/places-monitor-extension/using-places-monitor-extension.html#add-permissions-to-the-manifest)

 ##### Start the Places Monitor:

 ```dart
import 'package:flutter_acpplaces_monitor/flutter_acpplaces_monitor.dart';

FlutterACPPlacesMonitor.start();
 ```

 ##### Stop the Places Monitor:

 ```dart
bool clearPlacesData = true;
FlutterACPPlacesMonitor.stop(clearPlacesData);
 ```

 ##### Update the device's location:

 ```dart
FlutterACPPlacesMonitor.updateLocation();
 ```

 ##### Set or upgrade the location permission request (Android) / request authorization level (iOS):

 ```dart
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_location_permission.dart';

FlutterACPPlacesMonitor.setRequestLocationPermission(FlutterACPPlacesMonitorLocationPermission.ALWAYS_ALLOW);
FlutterACPPlacesMonitor.setRequestLocationPermission(FlutterACPPlacesMonitorLocationPermission.WHILE_USING_APP);
FlutterACPPlacesMonitor.setRequestLocationPermission(FlutterACPPlacesMonitorLocationPermission.NONE);
 ```

 ##### Set the monitoring mode (iOS only):

 ```dart
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_modes.dart';

FlutterACPPlacesMonitor.setPlacesMonitorMode(FlutterACPPlacesMonitorModes.CONTINUOUS);
FlutterACPPlacesMonitor.setPlacesMonitorMode(FlutterACPPlacesMonitorModes.SIGNIFICANT_CHANGES);
 ```

## Contributing
See [CONTRIBUTING](CONTRIBUTING.md)

## License
See [LICENSE](LICENSE)
