//
//  Buttons.swift
//  Design Code 1
//
//  Created by  mac on 02.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    
    
    
    var body: some View {
        VStack(spacing: 50.0) {
            RectangleButton()
            CircleButton2()
            PayButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 0.3962168236)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton: View {
    @State var isTapped: Bool = false
    @State var isPressed: Bool = false
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 0.3656892123)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(5)
                        .blur(radius: 2)
                    
                }
        )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .frame(width: isPressed ? 64 : 54, height: isPressed ? 4 : 50)
                        .foregroundColor(Color.white.opacity(isPressed ? 0 : 1))
                        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                        .offset(x: isPressed ? 70 : -10, y : isPressed ? 15 : 0)
                    
                    
                    Spacer()
                }
                
        )
            .shadow(color: Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .scaleEffect(isTapped ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 5)
                    .onChanged({ _ in
                        self.isTapped = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.isTapped = false
                        }
                    })
                    .onEnded({ (value) in
                        self.isPressed.toggle()
                    })
        )
    }
}

struct CircleButton2: View {
    @State var isTapped: Bool = false
    @State var isPressed: Bool = true
    var body: some View {
    ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: isPressed ? -90 : 0, y : isPressed ? -90 : 0)
                .rotation3DEffect(Angle(degrees: isPressed ? 20 : 0), axis: (x: 10, y: -10, z: 0))
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: isPressed ? 0 : 90, y : isPressed ? 0 : 90)
                .rotation3DEffect(Angle(degrees: isPressed ? 0 : 20), axis: (x: 10, y: -10, z: 0))
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ),  Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ), radius: 3, x: 3, y: 3)
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(isPressed ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) ), radius: 3, x: -3, y: -3)
            }
        )
            .clipShape(Circle())
        .shadow(color: Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1)  ), radius: 20, x: 20, y: 20)
        .shadow(color: Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ), radius: 20, x: -20, y: -20)
            .scaleEffect(isTapped ? 1.2 : 1)
            .gesture(LongPressGesture()
                .onChanged({ _ in
                    self.isTapped = true
                    HapticFeedback.shared.impact(of: .soft)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.isTapped = false
                    }
                })
                .onEnded({ (value) in
                    self.isPressed.toggle()
                })
        )
    }
}

struct PayButton: View {
    @GestureState var isTapped: Bool = false
    @State var isPressed: Bool = false
    var body: some View {
        ZStack {
            Image("fingerprint")
                .opacity(isPressed ? 0 : 1)
                .scaleEffect(isPressed ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y: isTapped ? 0 : 50))
                .animation(.easeInOut)
                .opacity(isPressed ? 0 : 1)
                .scaleEffect(isPressed ? 0 : 1)
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .opacity(isPressed ? 1 : 0)
                .scaleEffect(isPressed ? 1 : 0)
            
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ),  Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ), radius: 3, x: 3, y: 3)
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(isPressed ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8600998019, blue: 0.9254901961, alpha: 1) ), radius: 3, x: -3, y: -3)
            }
        )
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: isTapped ? 0.001 : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topLeading, endPoint: .topTrailing), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 88, height: 88)
                .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3)
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .animation(.easeInOut)
            
                
        )
        .shadow(color: Color(isPressed ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1)  ), radius: 20, x: 20, y: 20)
        .shadow(color: Color(isPressed ? #colorLiteral(red: 0.7607843137, green: 0.8156862745, blue: 0.9254901961, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ), radius: 20, x: -20, y: -20)
        .scaleEffect(isTapped ? 1.2 : 1)
        .gesture(LongPressGesture()
            .updating(self.$isTapped, body: { (currentState, gestureState, inoutTransaction) in
                gestureState = currentState
            })
            
            .onEnded({ (value) in
                HapticFeedback.shared.generate(of: .success)
                self.isPressed.toggle()
            })
        )
    }
}
