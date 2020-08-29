//
//  HomeView2.swift
//  Design Code 1
//
//  Created by  mac on 29.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct HomeView2: View {
    @Binding var showProfile: Bool
    @State var showUpdate: Bool = false
    @Binding var showContent: Bool
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizntalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Watching")
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                        AvatarView(showProfile: self.$showProfile)
                        Button(action: {
                            self.showUpdate.toggle()
                        }) {
                            Image(systemName: "bell")
                                .renderingMode(.original)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 1, y: 0)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        }
                        .sheet(isPresented: self.$showUpdate) {
                            UpdateList()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .blur(radius: self.active ? 20 : 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        WatchRingsView()
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .onTapGesture {
                                self.showContent = true
                            }
                    }
                    .blur(radius: self.active ? 20 : 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30.0) {
                            
                            ForEach(sectionsData) { item in
                                GeometryReader { bounds in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees: Double(bounds.frame(in: .global).minX - 30) /  -getAngleMultiplier(geometry: geometry)) , axis: (x: 0, y: 1, z: 0))
                                    }
                                    .frame(width: 275, height: 275)
                            }
                                
                        }
                        .padding(.horizontal ,30)
                        .padding(.bottom, 50)
                        .padding(.top, 20)
                    }
                    .blur(radius: self.active ? 20 : 0)
                    
                    Spacer()

                    HStack {
                        Text("Courses")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .offset(y: -40)
                    .blur(radius: self.active ? 20 : 0)
                   // CourseList()

                    VStack {
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { bounds in
                                ZStack {
                                    
                                    CourseView2 (
                                        show: self.$store.courses[index].show,
                                        active: self.$active, course: self.store.courses[index],
                                        index: index,
                                        activeIndex: self.$activeIndex,
                                        activeView: self.activeView, geometry: geometry
                                    )
                                        .offset(y: self.store.courses[index].show ? -bounds.frame(in: .global).minY : 0)
                                        .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                        .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                    //.offset(y: self.activeIndex != index && self.active && index > self.activeIndex ? screen.height : 0)
                                    //.offset(y: self.activeIndex != index && self.active && index < self.activeIndex ? -screen.height : 0)
                                }
                            }
                            .frame(height: self.horizntalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(geometry: geometry))
                        }
                    }
                    .offset(y: -40)
                }
                .frame(width: geometry.size.width)
            }
        }
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2(showProfile: .constant(false), showContent: .constant(false))
        .environmentObject(UserStore())
    }
}

func getAngleMultiplier(geometry: GeometryProxy) -> Double {
    if geometry.size.width > 500 {
        return 80
    }
    return 20
}

struct SectionView: View {
    
    var section: SectionData
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack {
                Text(section.title)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(section.logo)
            }
            Text(section.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 220)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: self.width, height: self.height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, percent: 68, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today").modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 32, percent: 32, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}

struct SectionData: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionsData = [
    
        SectionData(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
        SectionData(title: "Build a SwiftUI app", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card5")), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
        SectionData(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
    
]

