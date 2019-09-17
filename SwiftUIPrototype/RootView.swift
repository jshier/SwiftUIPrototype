//
//  ContentView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import Combine
import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HTTPBinView()) { Text("HTTPBinView") }
                NavigationLink(destination:
                    SheetExperimentsView()
                        .environmentObject(SheetState())
                ) { Text("Sheet Experiments") }
                NavigationLink(destination: WeatherView()) { Text("Weather") }
            }
            .navigationBarTitle("Prototypes")
        }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        RootView()
            
    }
}
