//
//  TabBar.swift
//  Design Code 1
//
//  Created by  mac on 26.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home2().tabItem {
                VStack {
                    Text("Home")
                    Image(systemName: "house")
                }
            }
            
            ContentView().tabItem {
                VStack {
                    Text("Certificates")
                    Image(systemName: "rectangle.stack")
                }
            }
            
            UpdateList().tabItem {
                VStack {
                    Text("Certificates")
                    Image(systemName: "gear")
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        //.padding(.top, 30)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environment(\.colorScheme, .dark)
    }
}
