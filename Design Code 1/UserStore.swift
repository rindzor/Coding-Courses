//
//  UserStore.swift
//  Design Code 1
//
//  Created by  mac on 03.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin: Bool = false
}

