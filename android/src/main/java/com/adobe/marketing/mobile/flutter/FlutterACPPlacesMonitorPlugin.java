package com.adobe.marketing.mobile.flutter;

import com.adobe.marketing.mobile.Places;
import com.adobe.marketing.mobile.PlacesMonitor;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterACPPlacesMonitorPlugin */
public class FlutterACPPlacesMonitorPlugin implements MethodCallHandler {

  private String TAG = "FlutterACPPlacesMonitorPlugin";

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_acpplaces_monitor");
    channel.setMethodCallHandler(new FlutterACPPlacesMonitorPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if ("extensionVersion".equals(call.method))  {
      result.success(PlacesMonitor.extensionVersion());
    } else if ("start".equals(call.method)) {
      PlacesMonitor.start();
      result.success(null);
    } else if ("stop".equals(call.method)) {
      handleStop(call.arguments);
      result.success(null);
    } else if ("updateLocation".equals(call.method)) {
      PlacesMonitor.updateLocation();
      result.success(null);
    } else if ("setRequestLocationPermission".equals(call.method)) {
      handleSetRequestLocationPermission(call.arguments);
      result.success(null);
    } else if ("setPlacesMonitorMode".equals(call.method)) {
      // No operation API does not exists for android.
      Log.d(TAG, "Setting Places monitor mode api does not exists for Android");
      result.success(null);
    } else {
      result.notImplemented();
    }
  }

  private void handleStop(Object arguments) {
    if (!(arguments instanceof Boolean)) {
      Log.e(TAG, "Places monitor stop failed because arguments were invalid");
      return;
    }

    boolean clearData = (Boolean) arguments;
    PlacesMonitor.stop(clearData);
  }

  private void handleSetRequestLocationPermission(Object arguments) {
    if (!(arguments instanceof String)) {
      Log.e(TAG, "Places monitor setting request location permission failed because arguments were invalid");
      return;
    }

    String request = (String) arguments;
    PlacesMonitor.setRequestLocationPermission(FlutterACPPlacesMonitorDataBridge.placesMonitorLocationPermissionFromString(request));
  }
}
