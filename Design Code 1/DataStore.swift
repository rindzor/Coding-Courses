//
//  DataStore.swift
//  Design Code 1
//
//  Created by  mac on 02.08.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    
    @Published var posts: [Post] = []
    
    init() {
        self.getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
