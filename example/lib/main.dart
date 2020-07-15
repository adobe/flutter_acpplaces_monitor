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
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_acpplaces_monitor/flutter_acpplaces_monitor.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_location_permission.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_modes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterACPPlacesMonitor.extensionVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text('ACPPlacesMonitor version = $_platformVersion\n'),
            RaisedButton(
              child: Text("ACPPlacesMonitor.start()"),
              onPressed: () => FlutterACPPlacesMonitor.start(),
            ),
            RaisedButton(
              child: Text("ACPPlacesMonitor.stop(clearData)"),
              onPressed: () => FlutterACPPlacesMonitor.stop(true),
            ),
            RaisedButton(
              child: Text("ACPPlacesMonitor.updateLocation()"),
              onPressed: () => FlutterACPPlacesMonitor.updateLocation(),
            ),
            RaisedButton(
              child: Text("ACPPlacesMonitor.setRequestLocationPermission()"),
              onPressed: () => FlutterACPPlacesMonitor.setRequestLocationPermission(FlutterACPPlacesMonitorLocationPermission.ALWAYS_ALLOW),
            ),
            RaisedButton(
              child: Text("ACPPlacesMonitor.setPlacesMonitorMode()"),
              onPressed: () => FlutterACPPlacesMonitor.setPlacesMonitorMode(FlutterACPPlacesMonitorModes.SIGNIFICANT_CHANGES),
            ),
          ]),
        ),
      ),
    );
  }
}
