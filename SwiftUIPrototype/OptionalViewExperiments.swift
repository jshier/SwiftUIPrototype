//
//  OptionalViewExperiments.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 1/17/20.
//  Copyright © 2020 Jon Shier. All rights reserved.
//

import SwiftUI

struct OptionalViewExperiments: View {
    var optional: String?
    
    var body: some View {
        OptionalView(optional,
                     valueView: { value in
                        if value.count > 3 {
                            Text("Greater than.")
                        } else {
                            Text("Less than.")
                        }
                     },
                     nilView: { Rectangle().background(Color.blue) })
            .navigationBarTitle("Optional Experiments", displayMode: .inline)
    }
}

struct OptionalViewExperimentsPreviews: PreviewProvider {
    static var previews: some View {
        OptionalViewExperiments(optional: "two")
    }
}

struct OptionalView<Value, ValueView: View, NilView: View>: View {
    private let valueView: ValueView?
    private let nilView: NilView?
    
    init(_ value: Value?, @ViewBuilder valueView: @escaping (Value) -> ValueView, @ViewBuilder nilView: @escaping () -> NilView) {
        self.valueView = value.map(valueView)
        self.nilView = (value == nil) ? nilView() : nil
    }
    
    @ViewBuilder
    var body: some View {
        valueView
        nilView
    }
}
