//
//  ResponseView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import SwiftUI

struct ResponseView: View {
    @ObservedObject var response = Resource<HTTPBinResponse, AFError>()
    
    var body: some View {
        VStack {
            Text(response.isLoading ? "Loading..." : "Not loading.")
            Text(response.value?.url ?? "No response yet.")
        }
    }
}

struct ResponseViewPreviews: PreviewProvider {
    static var previews: some View {
        ResponseView()
    }
}
