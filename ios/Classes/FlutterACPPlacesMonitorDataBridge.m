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

#import "FlutterACPPlacesMonitorDataBridge.h"

// @{link ACPPlacesMonitorRequestAuthorizationLevel}
static NSString* const ACP_PLACES_MONITOR_PERMISSION_WHILE_USING_APP = @"WHILE_USING_APP";
static NSString* const ACP_PLACES_MONITOR_PERMISSION_ALWAYS_ALLOW = @"ALWAYS_ALLOW";

// @{link ACPPlacesMonitorRequestAuthorizationLevel}
static NSString* const ACP_PLACES_MONITOR_MODE_CONTINUOUS = @"CONTINUOUS";

@implementation FlutterACPPlacesMonitorDataBridge

+ (ACPPlacesMonitorRequestAuthorizationLevel)authLevelFromString: (NSString *) authLevelString {
    if ([authLevelString isEqualToString:ACP_PLACES_MONITOR_PERMISSION_WHILE_USING_APP]) {
        return ACPPlacesMonitorRequestAuthorizationLevelWhenInUse;
    } else {
        return ACPPlacesRequestMonitorAuthorizationLevelAlways;
    }
}

+ (ACPPlacesMonitorMode)monitorModeFromString: (NSString *) mode {
    if ([mode isEqualToString:ACP_PLACES_MONITOR_MODE_CONTINUOUS]) {
        return ACPPlacesMonitorModeContinuous;
    } else {
        return ACPPlacesMonitorModeSignificantChanges;
    }
}

@end