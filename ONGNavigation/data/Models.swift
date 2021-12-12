//
//  models.swift
//  kind
//
//  Created by Daniel Surnin on 08.12.2021.
//

import Foundation


struct Answer : Codable{
    let articles: Array<Article>
}

struct Article: Codable, Identifiable, Hashable{
    let id = UUID()
    
    let title, description: String?
}
