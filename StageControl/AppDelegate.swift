//
//  AppDelegate.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Declare an array to hold the toggle switches
    var toggles = [NSButton]()
    
    // Declare a variable to hold the popover
    var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create and initialize the menu bar icon using MenuBarExtra
        let item =  MenuBarExtra("StageControl", systemImage: "square.3.layers.3d.down.right")
        item.button?.action = #selector(togglePopover(_:))
        MenuBarExtra.add(item)
        
        // Call a function to create the toggle switches
        createToggleSwitches()
    }
    
    // Function to create the toggle switches
    func createToggleSwitches() {
        let spaces = getSpaces()
        
        // Create a button for each space
        for space in spaces {
            let button = NSButton()
            button.title = space.name
            button.setButtonType(.switch)
            button.state = space.isActive ? .on : .off
            button.target = self
            button.action = #selector(toggleSpace(_:))
            toggles.append(button)
        }
        
        // Create the popover
        popover = NSPopover()
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSStackView(views: toggles)
    }
    
    // Function to get the list of spaces
    func getSpaces() -> [String] {
        let pid = NSProcessInfo.processInfo().processIdentifier
        let appRef = AXUIElementCreateApplication(pid)
        var value: AnyObject?
        AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)
        guard let windows = value as? [AXUIElement] else {
            return []
        }
        let desktops = windows.compactMap { window -> String? in
            var title: AnyObject?
            AXUIElementCopyAttributeValue(window, kAXTitleAttribute as CFString, &title)
            return title as? String
        }
        return desktops
    }
    
    // Function to toggle the state of a space
    @objc func toggleSpace(_ sender: NSButton) {
        let mc = MissionControl()
        let index = toggles.firstIndex(of: sender)!
        let space = getSpaces()[index]
        space.isActive = sender.state == .on
        mc.spaces = getSpaces()
    }
    
    // Function to toggle the popover
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(
                relativeTo: MenuBarExtra.item(withIdentifier: "com.example.myspaces")!.button!.bounds,
                of: MenuBarExtra.item(withIdentifier: "com.example.myspaces")!.button!,
                preferredEdge: .minY
            )
        }
    }
}
