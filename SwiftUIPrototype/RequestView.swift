//
//  RequestView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct RequestView: View {
    let request: SampleRequest
    
    var body: some View {
        VStack {
            Text(request.method.rawValue)
            Text("/\(request.path)")
        }
        .padding()
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct RequestViewPreviews: PreviewProvider {
    static var previews: some View {
        RequestView(request: SampleRequest())
    }
}
