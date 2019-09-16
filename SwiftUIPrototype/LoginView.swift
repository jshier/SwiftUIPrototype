//
//  LoginView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Binding var city: String
    
    var body: some View {
        Form {
            TextField("City", text: $city)
        }
    }
}

struct LoginViewPreviews: PreviewProvider {
    static var previews: some View {
        LoginView(city: .constant("Detroit, MI"))
    }
}
