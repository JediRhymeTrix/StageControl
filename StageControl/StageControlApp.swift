//
//  StageControlApp.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import SwiftUI

@main
struct StageControlApp: App {
    // Define a @StateObject property to hold the view model
    @StateObject var viewModel = CheckboxViewModel()
    // keep track of scene phase for retrieving the checkbox status on every click
    @Environment(\.scenePhase) var scenePhase
    // Keep track of the checkbox state
    @State var isChecked = false
    
    var body: some Scene {
        MenuBarExtra("StageControl", systemImage: "square.3.layers.3d.down.right") {
            Text("Toggle Stage Manager for current Space")
            
            CheckboxView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)
        .onChange(of: scenePhase) { newPhase in // This modifier allows us to detect change of scene.
            if newPhase == .active {
                // Load the checkbox state from AppStorage when the app appears
                //            isChecked = UserDefaults.standard.bool(forKey: getDesktopId())
            }
        }
    }
}
