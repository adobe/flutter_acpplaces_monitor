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

import 'package:flutter/services.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_location_permission.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_modes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_acpplaces_monitor/flutter_acpplaces_monitor.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_acpplaces_monitor');

  TestWidgetsFlutterBinding.ensureInitialized();

  group('extensionVersion', () {
    final String testVersion = "2.1.3";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testVersion;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.extensionVersion;

      expect(log, <Matcher>[
        isMethodCall(
          'extensionVersion',
          arguments: null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(await FlutterACPPlacesMonitor.extensionVersion, testVersion);
    });
  });

  group('start', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.start();

      expect(log, <Matcher>[
        isMethodCall(
          'start',
          arguments: null,
        ),
      ]);
    });
  });

  group('stop', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.stop(true);

      expect(log, <Matcher>[
        isMethodCall(
          'stop',
          arguments: true,
        ),
      ]);
    });
  });

  group('updateLocation', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.updateLocation();

      expect(log, <Matcher>[
        isMethodCall(
          'updateLocation',
          arguments: null,
        ),
      ]);
    });
  });

  group('setRequestLocationPermission', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.setRequestLocationPermission(
          FlutterACPPlacesMonitorLocationPermission.WHILE_USING_APP);

      expect(log, <Matcher>[
        isMethodCall(
          'setRequestLocationPermission',
          arguments: FlutterACPPlacesMonitorLocationPermission.WHILE_USING_APP.value,
        ),
      ]);
    });
  });

  group('setPlacesMonitorMode', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPPlacesMonitor.setPlacesMonitorMode(
          FlutterACPPlacesMonitorModes.CONTINUOUS);

      expect(log, <Matcher>[
        isMethodCall(
          'setPlacesMonitorMode',
          arguments: FlutterACPPlacesMonitorModes.CONTINUOUS.value,
        ),
      ]);
    });
  });
}
