//
//  ApiList.swift
//  Design Code 1
//
//  Created by  mac on 31.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI

struct ApiList: View {
    
    @ObservedObject var store = DataStore()
    
    var body: some View {
        
        List(store.posts) { post in
            Text(post.title)
        }
//        .onAppear(perform: {
//            CourseStore().getArray()
//        })
       
    }
}

struct ApiList_Previews: PreviewProvider {
    static var previews: some View {
        ApiList()
    }
}
