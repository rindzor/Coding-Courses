//
//  FontModifier.swift
//  Design Code 1
//
//  Created by  mac on 30.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomFontModifier : ViewModifier {
    var size: CGFloat = 28
    func body(content: Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: size))
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}
