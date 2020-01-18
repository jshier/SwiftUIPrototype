//
//  GestureExperiments.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 11/5/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct GestureExperiments: View {
    var body: some View {
        VStack {
            Text("Gestures")
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("Tapped!")
        }
    }
}

struct GestureExperiments_Previews: PreviewProvider {
    static var previews: some View {
        GestureExperiments()
    }
}
