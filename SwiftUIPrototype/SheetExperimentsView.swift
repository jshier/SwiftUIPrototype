//
//  SheetExperimentsView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/16/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct SheetExperimentsView: View {
    @EnvironmentObject var appState: SheetState
    
    var body: some View {
        VStack {
            Button(action: { self.appState.needsCity = true }) {
                Text("Set City")
            }
            .sheet(isPresented: $appState.needsCity, onDismiss: { self.appState.needsCity = false }) {
                LoginView(city: self.$appState.city)
            }
            Button(action: { self.appState.needsState = true }) {
                Text("Set State")
            }
            .sheet(isPresented: $appState.needsState, onDismiss: { self.appState.needsState = false }) {
                LoginView(city: self.$appState.state)
            }
        }
    }
}

struct SheetExperimentsView_Previews: PreviewProvider {
    static var previews: some View {
        SheetExperimentsView()
    }
}
