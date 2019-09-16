//
//  AppState.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/15/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Combine
import Foundation

final class AppState: ObservableObject {
    @Published var needsCity = false
    @Published var city = "Detroit, MI"
    @Published var needsState = false
    @Published var state = "Michigan"
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
//        cancellables = [
//            self.$city.map { $0 != nil }.sink { self.needsCity = $0 }
//        ]
    }
}
