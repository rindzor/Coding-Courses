//
//  SuccessView.swift
//  Design Code 1
//
//  Created by  mac on 03.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    @State var show: Bool = false
    var body: some View {
        VStack {
            Text("Logging you...")
                .font(.title)
                .bold()
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration : 1).delay(0.2))
            LottieView(fileName: "success")
                .frame(width: 300, height: 300)
                .animation(Animation.linear(duration : 1).delay(0.4))
            .opacity(show ? 1 : 0)
        }
        .padding(.top, 30)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .edgesIgnoringSafeArea(.all)
        .animation(.linear(duration: 2))
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
