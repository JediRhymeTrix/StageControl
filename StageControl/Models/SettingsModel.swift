//
//  SettingsModel.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import SwiftUI

class Settings: ObservableObject {
    static let shared = Settings()
    
    private init() { }
    
    @AppStorage("config") var config: String = UserDefaults.standard.string(forKey: "config") ?? ""
}

