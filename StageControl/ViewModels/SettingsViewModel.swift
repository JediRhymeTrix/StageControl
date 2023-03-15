//
//  SettingsViewModel.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import Foundation
import ScriptingBridge
import SwiftUI

// Define a view model to handle the business logic
class CheckboxViewModel: ObservableObject {
    // Define a @Published property to hold the checkbox state and the current desktop
    @Published var model: CheckboxModel
    
    init() {
        // Initialize the model with the default values
        model = CheckboxModel(isChecked: false, desktopName: "")
        // Set the current desktop name
        model.desktopName = getCurrentSpaceUUID()
        // Retrieve the checkbox value from AppStorage
        //        let desktopId = NSScreen.main?.displayIdentifier ?? ""
        //        model.isChecked = UserDefaults.standard.bool(forKey: "checkboxValue_\(desktopId)")
    }
    
    // Define a function to store the checkbox value in AppStorage
    func saveCheckboxValue() {
        //        let desktopId = NSScreen.main?.displayIdentifier ?? ""
        //        UserDefaults.standard.set(model.isChecked, forKey: "checkboxValue_\(desktopId)")
    }
    
    // Define a helper function to get the name of the current desktop
    func getCurrentSpaceUUID() -> String? {
        // Create an instance of the Scripting Bridge Application object for System Events
        guard let systemEvents = SBApplication(bundleIdentifier: "com.apple.systemevents") else {
            return nil
        }
        
        // Get the current desktop's number
        guard let currentDesktopNumber = systemEvents.desktops?().first?.number?() else {
            return nil
        }
        
        // Get the UUID of the space associated with the current desktop
        let script = """
        tell application "System Events"
            set spaceUUID to UUID of (item \(currentDesktopNumber) of spaces preferences)
            return spaceUUID
        end tell
        """
        var error: NSDictionary?
        guard let spaceUUID = systemEvents.executeAndReturnError(&error, withAppleEvent: script).stringValue else {
            return nil
        }
        
        return spaceUUID
    }
    
    private func getScreenWithMouse() -> NSScreen? {
        let mouseLocation = NSEvent.mouseLocation
        let screens = NSScreen.screens
        let screenWithMouse = (screens.first { NSMouseInRect(mouseLocation, $0.frame, false) })
        
        return screenWithMouse
    }
}
