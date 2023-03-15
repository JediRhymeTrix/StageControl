//
//  ContentView.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text(ContentViewModel().mergeConfig())
        }
    }
}
