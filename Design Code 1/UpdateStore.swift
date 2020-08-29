//
//  UpdateStore.swift
//  Design Code 1
//
//  Created by  mac on 25.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
