//
//  Resource.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import Combine
import SwiftUI

final class Resource<Success, Failure: Error>: ObservableObject {
    @Published private (set) var isLoading = false
    @Published private (set) var result: Result<Success, Failure>?
    @Published private (set) var value: Success?
    @Published private (set) var error: Failure?

    private var cancellable: AnyCancellable?

    init() {
        cancellable = $result.compactMap { $0 }.sink { newResult in
            switch newResult {
            case let .success(value): self.value = value
            case let .failure(error): self.error = error
            }
        }
    }

    func update(_ newResult: Result<Success, Failure>) {
        result = newResult
    }
    
    // Separate this out, otherwise compiler crashes when calling from perform.
    func startLoading() {
        isLoading = true
    }
}

extension Resource where Success: Decodable, Failure == AFError {
    func perform(_ request: URLRequestConvertible) {
        startLoading()
        AF.request(request).responseDecodable(of: Success.self) { self.update($0.result); self.isLoading = false }
    }
}

struct HTTPBinResponse: Decodable {
    let headers: [String: String]
    let origin: String
    let url: String
    let data: String?
    let form: [String: String]?
    let args: [String: String]
}
