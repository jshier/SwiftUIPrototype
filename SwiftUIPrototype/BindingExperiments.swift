//
//  BindingExperiments.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 10/31/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Combine
import SwiftUI

struct BindingExperiments: View {
    @State var valid: String? {
        didSet {
            print(valid ?? "nil")
        }
    }
    
    var body: some View {
        VStack {
            Subview(validText: $valid)
            valid.map { Text("Valid Output! \($0)") }
            Button(action: { print(self.valid ?? "Button value is nil.") }) { Text("Show Text") }
        }
    }
}

struct Subview: View {    
    @ObservedObject var validator: Validator
    
    var body: some View {
        TextField("Enter", text: $validator.enteredText)
    }
    
    init(validText: Binding<String?>) {
        validator = Validator(output: validText)
    }
    
    final class Validator: ObservableObject {
        @Published var enteredText = "" {
            didSet {
                output = (enteredText.count == 8) ? enteredText : nil
            }
        }
        
        @Binding var output: String?
        
        init(output: Binding<String?>) {
            _output = output
        }
    }
}

struct BindingExperimentsPreviews: PreviewProvider {
    static var previews: some View {
        BindingExperiments()
    }
}
