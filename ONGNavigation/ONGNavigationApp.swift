//
//  ONGNavigationApp.swift
//  ONGNavigation
//
//  Created by Daniel Surnin on 13.12.2021.
//

import SwiftUI

let model = NewsListViewModel(api: NewsApiImpl())

@main
struct ONGNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(listVM: model).environmentObject(model)
        }
    }
}
