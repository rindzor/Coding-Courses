//
//  ViewExtensions.swift
//  Design Code 1
//
//  Created by  mac on 31.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation
import SwiftUI

public extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}
