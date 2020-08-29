//
//  Home2.swift
//  Design Code 1
//
//  Created by  mac on 28.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct Home2: View {
    
    @State var showProfile: Bool = false
    @State var viewState = CGSize.zero
    @State var showContent: Bool = false
    @EnvironmentObject var user: UserStore
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView2(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, statusBarHeight)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background5").opacity(0.5), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
                )
                .clipShape(RoundedRectangle(cornerRadius: showProfile ? 20 : 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .rotation3DEffect(Angle(degrees: Double(showProfile ? (-viewState.height/10 + 10) : 0)), axis: (x: -10, y: 0, z: 0))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.3))
                .edgesIgnoringSafeArea(.all)
            
            BottomMenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.000001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.3))
                .onTapGesture {
                    self.showProfile.toggle()
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        if self.viewState.height > 50 {
                            self.showProfile = false
                            self.viewState = CGSize.zero
                        } else {
                            self.viewState = CGSize.zero
                        }
                    }
            )
            
            if user.showLogin {
                
                ZStack {
                    LoginView()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 37, height: 37)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.trailing)
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0))
                    .onTapGesture {
                        self.user.showLogin = false
                    }
                }
            }
            
            if showContent {
                
                Color.white.edgesIgnoringSafeArea(.all)
            
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                        .frame(width: 37, height: 37)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.trailing)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
                
            }
            
            
        }
    
    }
}


struct AvatarView: View {
    @Binding var showProfile: Bool
    @EnvironmentObject var user: UserStore
    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: {
                self.showProfile.toggle()
            }) {
                Image("Avatar")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                }
            } else {
                Button(action: {
                    self.user.showLogin.toggle()
                }) {
                    Image(systemName: "person.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 1, y: 0)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
            }
        }
    }
}

struct Home2_Previews: PreviewProvider {
    static var previews: some View {
        Home2()
        .environmentObject(UserStore())
    }
}
