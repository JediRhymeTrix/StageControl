//
//  SettingsViewModel.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import AppKit
import SwiftUI

class ContentViewModel: ObservableObject {
    func mergeConfig() -> String {
        let savedConfig = Settings.shared.config
//        let savedConfigDict = try! JSONSerialization.jsonObject(with: savedConfig.data(using: .utf8)!, options: []) as! [Int32: Bool]
        
        let emptyConfig = createEmptyConfig()
        
//        if savedConfig == "" {
//            return config
//        }
//        if config == "" {
//            return savedConfig
//        }
//
//        let configDict = try! JSONSerialization.jsonObject(with: config.data(using: .utf8)!, options: []) as! [String: Any]
//
//        let mergedConfig = try! JSONSerialization.data(withJSONObject: configDict.merging(savedConfigDict, uniquingKeysWith: { (current, _) in current }), options: [])
//        return String(data: mergedConfig, encoding: .utf8)!
        
        return ""
    }
    
    private func createEmptyConfig() -> [String: Bool] {
        let spaces = getSpaces()
        
        return [:]
    }
    
    @objc
    private func getSpaces() -> [String: UInt32] {
        let screens = NSScreen.screens
        let workspace = NSWorkspace.shared
        
        for screen in screens {
            if let screenFrame = screen.frame as? CGRect {
                let runningApps = workspace.runningApplications
                for app in runningApps {
                    if app.isActive {
                        if let windows: Any = app.windows {
                            for window in windows {
                                if window.isOnActiveSpace && window.frame.intersects(screenFrame) {
                                    print("Desktop on screen \(screen) belongs to app \(app)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func readPlist(path: String) -> [String: String] {
        let contents = NSDictionary(contentsOfFile: path) as? [String: String] ?? [:]
        
        return contents
    }
                    
}
