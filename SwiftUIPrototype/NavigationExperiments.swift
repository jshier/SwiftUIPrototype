//
//  NavigationExperiments.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 10/17/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct NavigationExperiments: View {
    @EnvironmentObject var state: NavigationState
    
    var body: some View {
        VStack {
            NavigationLink(destination: First(), isActive: $state.showingFirst, label: { Text("First") })
            Button(action: { self.state.showingFirst = true }) { Text("Show First") }
        }
    }
}

struct First: View {
    @EnvironmentObject var state: NavigationState
    
    var body: some View {
       VStack {
            Text("First")
            NavigationLink(destination: Second(), isActive: $state.showingSecond, label: { Text("Second") })
            Button(action: { self.state.showingFirst = false }) { Text("Pop") }
        }
    }
}

struct Second: View {
    @EnvironmentObject var state: NavigationState
    
    var body: some View {
        VStack {
            Text("Second")
            NavigationLink(destination: Third(), isActive: $state.showingThird, label: { Text("Third") })
            Button(action: { self.state.showingSecond = false }) { Text("Pop Second") }
            Button(action: { self.state.showingFirst = false }) { Text("Pop First") }
        }
    }
}

struct Third: View {
    @EnvironmentObject var state: NavigationState
    
    var body: some View {
        VStack {
            Text("Third")
            Button(action: { self.state.showingThird = false }) { Text("Pop") }
        }
    }
}

final class NavigationState: ObservableObject {
    @Published var showingFirst = false {
        didSet {
            print("showingFirst updated: \(showingFirst)")
        }
    }
    
    @Published var showingSecond = false {
        didSet {
            print("showingSecond updated: \(showingSecond)")
        }
    }
    
    @Published var showingThird = false {
        didSet {
            print("showingThird updated: \(showingThird)")
        }
    }
}

struct NavigationExperimentsPreviews: PreviewProvider {
    static var previews: some View {
        NavigationExperiments()
    }
}
