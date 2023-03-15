//
//  StageControlApp.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import SwiftUI

@main
struct StageControlApp: App {
    var body: some Scene {
        MenuBarExtra("StageControl", systemImage: "square.3.layers.3d.down.right") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}
