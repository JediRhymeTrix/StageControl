//
//  SettingsViewModel.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

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
    
    private func getSpaces() -> [String: UInt32] {
        let spaces = [String: UInt32]()
        
        let plistFileName = "~/Library/Preferences/com.apple.spaces.plist"
        let spacesPlist = readPlist(path: plistFileName)
        
        print(spacesPlist)
        
        return spaces
    }
    
    private func readPlist(path: String) -> [String: String] {
        let contents = NSDictionary(contentsOfFile: path) as? [String: String] ?? [:]
        
        return contents
    }
                    
}
