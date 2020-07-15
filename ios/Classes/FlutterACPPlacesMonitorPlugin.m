/*
Copyright 2020 Adobe. All rights reserved.
This file is licensed to you under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
OF ANY KIND, either express or implied. See the License for the specific language
governing permissions and limitations under the License.
*/

#import "FlutterACPPlacesMonitorPlugin.h"
#import "FlutterACPPlacesMonitorDataBridge.h"
#import "ACPPlacesMonitor.h"

@implementation FlutterACPPlacesMonitorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_acpplaces_monitor"
            binaryMessenger:[registrar messenger]];
  FlutterACPPlacesMonitorPlugin* instance = [[FlutterACPPlacesMonitorPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"extensionVersion" isEqualToString:call.method]) {
    result([ACPPlacesMonitor extensionVersion]);
  } else if ([@"start" isEqualToString:call.method]) {
    [ACPPlacesMonitor start];
    result(nil);
  } else if ([@"stop" isEqualToString:call.method]) {
    BOOL shouldClearPlacesData = call.arguments;
    [ACPPlacesMonitor stop:shouldClearPlacesData];
    result(nil);
  } else if ([@"updateLocation" isEqualToString:call.method]) {
    [ACPPlacesMonitor updateLocationNow];
    result(nil);
  } else if ([@"setRequestLocationPermission" isEqualToString:call.method]) {
    NSString *permission = call.arguments;
    [ACPPlacesMonitor setRequestAuthorizationLevel:[FlutterACPPlacesMonitorDataBridge authLevelFromString:permission]];
    result(nil);
  } else if ([@"setPlacesMonitorMode" isEqualToString:call.method]) {
    NSString *mode = call.arguments;
    [ACPPlacesMonitor setPlacesMonitorMode: [FlutterACPPlacesMonitorDataBridge monitorModeFromString:mode]];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
