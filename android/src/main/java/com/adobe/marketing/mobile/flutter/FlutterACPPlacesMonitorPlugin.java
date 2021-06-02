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

package com.adobe.marketing.mobile.flutter;

import com.adobe.marketing.mobile.PlacesMonitor;

import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterACPPlacesMonitorPlugin
 */
public class FlutterACPPlacesMonitorPlugin implements FlutterPlugin, MethodCallHandler {

    private final String TAG = "FlutterACPPlacesMonitorPlugin";
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_acpplaces_monitor");
        channel.setMethodCallHandler(new FlutterACPPlacesMonitorPlugin());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if ("extensionVersion".equals(call.method)) {
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
