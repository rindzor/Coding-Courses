//
//  CourseList.swift
//  Design Code 1
//
//  Created by  mac on 30.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
//    @State var courses = courseData
    
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizntalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(Double(self.activeView.height/500))
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: self.active ? true : false)
                    .animation(.linear)
                
                ScrollView {
                    VStack(spacing: 30) {
                        Text("Courses")
                            .font(.system(.largeTitle))
                            .fontWeight(.bold)
                            .alignmentGuide(.leading, computeValue: { _ in -30})
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                            .animation(nil)
                        

                    }
                    .frame(width: geometry.size.width)
                    .padding(.bottom, 300)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
                }
            }
        }
    }
}

func getCardWidth(geometry: GeometryProxy) -> CGFloat {
    if geometry.size.width > 712 {
        return 712
    }
    
    return geometry.size.width - 60
}

func getCardCornerRadius(geometry: GeometryProxy) -> CGFloat {
    if geometry.size.width < 712 && geometry.safeAreaInsets.top < 44 {
        return 0
    }
    return 30
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView2: View {
    @Binding var show: Bool
    @Binding var active: Bool
    var course: CourseData
    var index: Int
    @Binding var activeIndex: Int
    @State var activeView = CGSize.zero
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(geometry: geometry) : 30 , style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(geometry: geometry) : 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                .offset(y: show ? -statusBarHeight / 2 : 0)
                .gesture(
                    self.show ?
                    DragGesture()
                    .onChanged { value in
                        guard value.translation.height < 300 else { return }
                        guard value.translation.height > 0 else { return }
                        
                        self.activeView = value.translation
                    }
                    .onEnded { value in
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                        }
                        self.activeView = .zero
                    }
                    : nil
                
                )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
        }
            
        .frame(height: show ? geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom : 280)
        .scaleEffect((1 - (self.activeView.height) / 1000))
        .offset(y: CGFloat(-Double(self.activeView.height) / 20))
        //.rotation3DEffect(Angle(degrees: Double(self.activeView.height) / 20), axis: (x: -1, y: 0, z: 0))
        .animation(.spring()).hueRotation(Angle(degrees: Double(self.activeView.height) / 5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseData : Identifiable{
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

let courseData = [
    
    CourseData(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    CourseData(title: "SwiftUI Advanced", subtitle: "20 Sections",  image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    CourseData(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/6z67xs71hbyy6ds/Card4%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
