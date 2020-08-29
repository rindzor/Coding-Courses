//
//  LoginView.swift
//  Design Code 1
//
//  Created by  mac on 03.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isTyping: Bool = false
    @State var isMoving: Bool = false
    @State var showAlert: Bool = false
    @State var errorMessage: String = "Something went wrong"
    @State var isLoading: Bool = false
    @State var isSuccess: Bool = false
    @EnvironmentObject var user: UserStore
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    fileprivate func login() {
        self.hideKeyboard()
        self.isTyping = false
        self.isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            if error != nil {
                self.errorMessage = error!.localizedDescription
                self.showAlert = true
            } else {
                self.isSuccess = true
                self.user.isLogged = true
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isSuccess = false
                    self.user.showLogin = false
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top) {

                Color("primary")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView(isMoving: self.$isMoving)
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .onTapGesture {
                                self.isTyping = true
                            }
                    }
                    
                    Divider()
                        .padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Your email".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .onTapGesture {
                                self.isTyping = true
                            }
                        
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)
                
                HStack{
                    Text("Forgot password?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                    }) {
                        Text("Log in")
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 20)
                    .alert(isPresented: self.$showAlert) {
                        Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .offset(y: isTyping ? -250 : 0)
            .animation((isTyping && !isMoving) ? .easeInOut : nil )
            .onTapGesture {
                self.hideKeyboard()
                
                self.isTyping = false
            }
            if isLoading {
                LoadingView()
            }
            if isSuccess {
                SuccessView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .environmentObject(UserStore())
    }
}

struct CoverView: View {
    @State var endleesShowing: Bool = false
    @State var viewState = CGSize.zero
    @Binding var isMoving: Bool
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn code & design.\nFrom scratch")
                    .font(.system(size: geometry.size.width / 10, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: viewState.width/16, y: viewState.height/16)
            
            
            Text("90 hours of courses for SwiftUI, UIKit, React and design tools")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    
                    .rotationEffect(Angle(degrees: endleesShowing ? 360 + 90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever())
                    //.animation(nil)
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .blendMode(.hardLight)
                    .rotationEffect(Angle(degrees: endleesShowing ? 360 : 0), anchor: .top)
                    .animation(Animation.linear(duration: 100).repeatForever())
                //.animation(nil)
            }
            .onAppear(perform: {
                self.endleesShowing = true
            })
        )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3"))
                    .offset(x: viewState.width/25, y: viewState.height/25)
                , alignment: .bottom
        )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isMoving ? 0.9 : 1)
            .animation(.spring())
            //.animation(nil)
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
            
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        self.viewState = value.translation
                        self.isMoving = true
                    })
                    .onEnded({ (value) in
                        self.viewState = CGSize.zero
                        self.isMoving = false
                    })
        )
    }
}
