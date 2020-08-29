//
//  HapticFeedback.swift
//  Design Code 1
//
//  Created by  mac on 03.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation
import SwiftUI

class HapticFeedback {
    static let shared = HapticFeedback()
    
    func generate(of type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    func impact(of style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
