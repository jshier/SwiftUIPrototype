//
//  HTTPBinView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/16/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import SwiftUI

struct HTTPBinView: View {
    @State var isPerformingRequest = false
    @State var selectedRequest: SampleRequest?
    
    var body: some View {
        VStack {
            ForEach(SampleRequest.samples, id: \.self) { request in
                RequestView(request: request)
                    .onTapGesture { self.selectedRequest = request }
                    .sheet(item: self.$selectedRequest, onDismiss: { self.selectedRequest = nil }) { toPerform in
                        self.responseView(request: toPerform)
                    }
            }
        }
    }
    
    func responseView(request: SampleRequest) -> ResponseView {
        let view = ResponseView()
        
        view.response.perform(request)
        
        return view
    }
}

struct HTTPBinView_Previews: PreviewProvider {
    static var previews: some View {
        HTTPBinView()
    }
}

struct SampleRequest: Hashable, URLRequestConvertible {
    static let samples: [SampleRequest] = [
        SampleRequest(),
        SampleRequest(method: .post, path: "post"),
        SampleRequest(method: .put, path: "put"),
        SampleRequest(method: .patch, path: "patch"),
        SampleRequest(method: .delete, path: "delete")
    ]
    
    var method = HTTPMethod.get
    var path = "get"
    
    func asURLRequest() throws -> URLRequest {
        var url = try "https://httpbin.org".asURL()
        url = url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}

extension SampleRequest: Identifiable {
    var id: Int { hashValue }
}

extension String: Identifiable {
    public var id: String { self }
}
