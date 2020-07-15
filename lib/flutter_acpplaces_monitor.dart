import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_location_permission.dart';
import 'package:flutter_acpplaces_monitor/src/flutter_acpplaces_monitor_modes.dart';

/// Adobe Experience Platform Places Monitor API.
class FlutterACPPlacesMonitor {
  static const MethodChannel _channel =
  const MethodChannel('flutter_acpplaces_monitor');

  /// Gets the current Places Monitor extension version.
  static Future<String> get extensionVersion async {
    final String version = await _channel.invokeMethod('extensionVersion');
    return version;
  }

  /// Start tracking the device's location and monitoring corresponding nearby POI's
  static Future<void> start() async {
    await _channel.invokeMethod<void>('start');
  }

  /// Stop tracking the device's location and nearby POI's.
  static Future<void> stop(bool clearData) async {
    await _channel.invokeMethod<void>('stop', clearData);
  }

  static Future<void> updateLocation() async {
    await _channel.invokeMethod<void>('updateLocation');
  }

  static Future<void> setRequestLocationPermission(FlutterACPPlacesMonitorLocationPermission permission) async {
    await _channel.invokeMethod<void>('setRequestLocationPermission', permission.value);
  }

  static Future<void> setPlacesMonitorMode(FlutterACPPlacesMonitorModes mode) async {
    await _channel.invokeMethod<void>('setPlacesMonitorMode', mode.value);
  }
}

