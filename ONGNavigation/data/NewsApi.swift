//
//  NewsApi.swift
//  kind
//
//  Created by Daniel Surnin on 08.12.2021.
//

import Foundation

protocol NewsApi {
    func news (term: String) async throws -> Answer
}

class NewsApiImpl : NewsApi{
    
    func news(term: String) async throws -> Answer {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://newsapi.org/v2/everything?q=\(term)&apiKey=ff2ce30b62e64151b5eb5710569600e8")!)
        return try JSONDecoder().decode(Answer.self, from: data);
    }
}
