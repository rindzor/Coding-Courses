//
//  ContentView.swift
//  Design Code 1
//
//  Created by  mac on 21.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFullScreen = false
    
    var body: some View {
        ZStack {
            
            BlurView(style: .systemMaterial)
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
                .opacity(showCard ? 0.4 : 1)
                .offset( y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
                )
                        
            CardView()
                .frame(maxWidth: showCard ? 300 : 340)
                .frame(height: 220.0)
                .background(show ? Color.red : Color("background9"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y : showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(Angle(degrees: show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: show && !showCard ? 10 : 0), axis: (x: 10, y: 0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.6))
            
            CardView()
                .frame(maxWidth: 340)
                .frame(height: 220.0)
                .background(show ? Color("background5") : Color("background8"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y : showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle(degrees: show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: show && !showCard ? 5 : 0), axis: (x: 10, y: 0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.4))
            

            CertificateView()
                .frame(maxWidth: showCard ? 375 : 340)
                    .frame(height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(radius: 10)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                //.rotationEffect(Angle(degrees: show ? 5 : 0))
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded { value in
                            self.viewState = CGSize.zero
                            self.show = false
                        }
                )

            GeometryReader { geometry in
                CardBottomView(showRingAnimation: self.$showCard)
                    .blur(radius: self.show ? 20 : 0)
                    .offset(y: self.showCard ? geometry.size.height / 2 : geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom )
                    .offset(y: self.bottomState.height)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    
                    .gesture(
                        DragGesture()
                            .onChanged{ (value) in
                                self.bottomState = value.translation
                                if self.showFullScreen {
                                    self.bottomState.height += -300
                                }
                                if self.bottomState.height < -300 {
                                    self.bottomState.height = -300
                                }
                            }
                        .onEnded{ (value) in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                                self.bottomState = CGSize.zero
                            }
                            if (self.bottomState.height < -100 && !self.showFullScreen) || (self.bottomState.height < -250 && self.showFullScreen){
                                self.bottomState.height = -300
                                self.showFullScreen = true
                            } else {
                                self.bottomState = CGSize.zero
                                self.showFullScreen = false
                            }
                        }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView : View {
    var body: some View {
        return VStack {
            Spacer()
        }
    }
}

struct CertificateView : View {
    
    var item = Certificate(title: "UI Design", image: "Card1", width: 340, height: 220)
    
    var body: some View {
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top)
                    Text("Certificate")
                        .foregroundColor(.white)
                }
                Spacer()
                Image("Logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
            }
            .padding(.horizontal, 20)
            Spacer()
            Image(item.image)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .offset(y: 50)
        }
        
    }
}

struct TitleView : View {
    var body: some View {
        return VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.leading, 20)
            Image("Certificate")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 375)
            Spacer()
        }
        //.padding()
    }
}

struct CardBottomView : View {
    @Binding var showRingAnimation: Bool
    var body: some View {
        return VStack(spacing: 20.0) {
            Rectangle()
                .frame(width: 60, height: 6)
                .cornerRadius(3.0)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .lineLimit(10)
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), width: 88, percent: 72, show: $showRingAnimation)
                    .animation(Animation.easeInOut.delay(0.3))
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI Prototype")
                        .fontWeight(.bold)
                    Text("SwiftUI Prototype")
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                    .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            }
            Spacer()
            }
            .frame(minWidth: 0, maxWidth: 712)
            .padding()
            .padding(.horizontal)
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(30)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity)
            
        
    }
}
