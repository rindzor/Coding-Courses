//
//  HomeView.swift
//  Design Code 1
//
//  Created by  mac on 22.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
var statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

let screen = UIScreen.main.bounds

struct HomeView: View {
    @State var show: Bool = false
    @State var showProfile: Bool = false
    @State var showUpdate: Bool = false
    @State var showProfileSettings: Bool = false
     var body: some View {
        ZStack(alignment: .top) {
            
            HomeList()
                .blur(radius: self.show ? 20 : 0)
                .scaleEffect(self.showProfile ? 0.95 : 1)
                .animation(.default)
            
            ContentView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.spring())
                .offset(y: self.showProfile ? statusBarHeight + 40 : UIScreen.main.bounds.height)
            
            MenuButton(show: self.$show)
                .animation(.spring())
                .offset(x: -30, y: showProfile ? statusBarHeight : 48 )
            
            MenuRight(showProfileSettings: self.$showProfileSettings, showUpdate: self.$showUpdate)
                .animation(.spring())
                .offset(x: -16, y: showProfile ? statusBarHeight : 48)
            
            MenuView(show: self.$show)
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Group {
            HomeView()
//            HomeView().previewDevice("iPhone X")
//            HomeView().previewDevice("iPad Pro (9.7-inch)")
//        }
    }
}

struct MenuRow: View {
    
    var image = "creditcard"
    var text = "My account"
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color("icons"))
                .frame(width: 32, height: 32)
            Text(text)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu : Identifiable {
    var id = UUID()
    var title : String
    var icon : String
}

let menuData = [
    Menu(title: "My account", icon: "person.crop.circle"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "Sign out", icon: "arrow.uturn.down")
]

struct MenuView: View {
    
    @Binding var show: Bool
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                
                ForEach(menuData) { (item) in
                    MenuRow(image: item.icon , text: item.title)
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0, maxWidth: 360)
            .background(Color("button"))
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 50), axis: (x: 0, y: 10, z: 0))
            .animation(.linear)
            .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
       
    }
}

struct CircleButton: View {
    var icon : String = ""
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.primary)
        }
        .frame(width: 44, height: 44)
        .background(Color("button"))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
//        .offset(y: -screen.height/2.25)
    }
}

struct MenuButton: View {
    
    @Binding var show: Bool
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Button(action: {
                self.show.toggle()
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .foregroundColor(Color.primary)
                }
                .padding(.trailing, 20)
                .frame(width: 90, height: 60)
                .background(Color("button"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
            }
            Spacer()
        }
        .offset(x: -screen.width / 2 + 40)
    }
}

struct MenuRight: View {
    @Binding var showProfileSettings: Bool
    @Binding var showUpdate: Bool
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Spacer()
                Button(action: {
                    self.showProfileSettings.toggle()
                }) {
                    CircleButton(icon: "person.crop.circle")
                }
                
                Button(action: { self.showUpdate.toggle() }) {
                    CircleButton(icon: "bell")
                        .sheet(isPresented: self.$showUpdate) { UpdateList() }
                }
            }
            
        }
    }
}
