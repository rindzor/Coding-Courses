//
//  Api.swift
//  Design Code 1
//
//  Created by  mac on 31.07.2020.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation

class Api {
    func getPosts(onSuccess: @escaping ([Post]) -> () ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let safeData = data {
                print(safeData)
                let posts = try! JSONDecoder().decode([Post].self, from: safeData)
                DispatchQueue.main.async {
                    print(posts ?? "fuck you")
                    onSuccess(posts)
                }
            }
                
        }
        .resume()
    }
}

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
    //var userId: Int
}

