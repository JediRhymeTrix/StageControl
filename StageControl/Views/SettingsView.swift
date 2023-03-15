//
//  ContentView.swift
//  StageControl
//
//  Created by Vedant Vohra on 3/15/23.
//

import SwiftUI

// Define a view to display the checkbox and the current desktop name
struct CheckboxView: View {
    // Define a @ObservedObject property to hold the view model
    @ObservedObject var viewModel: CheckboxViewModel
    
    var body: some View {
        VStack {
            Checkbox(text: viewModel.model.desktopName, isChecked: $viewModel.model.isChecked)
                .padding()
            Spacer()
        }
        .frame(width: 200, height: 50)
        .onChange(of: viewModel.model.isChecked) { _ in
            // Store checkbox value in AppStorage
            viewModel.saveCheckboxValue()
        }
    }
}

// Define a checkbox view
struct Checkbox: View {
    let text: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isChecked ? .blue : .gray)
                .onTapGesture {
                    isChecked.toggle()
                    CheckboxViewModel().saveCheckboxValue()
                }
            Text(text)
        }
    }
}
