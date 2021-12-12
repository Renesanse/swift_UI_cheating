//
//  ContentView.swift
//  ONGNavigation
//
//  Created by Daniel Surnin on 13.12.2021.
//

import SwiftUI


struct ContentView: View {
    let listVM: NewsListViewModel
    @State var term = ""
    
    var body: some View {
        NavigationView{
            NewsList().padding(.horizontal, 8.0)
        }.searchable(text: $term).onSubmit(of:.search) {
            listVM.fetch(term: term)
        }.refreshable {
            listVM.fetch()
        }
        .onAppear{
            listVM.fetch()
        }
        .padding(.horizontal, -8.0)
    }
}

struct NewsList: View{
    @EnvironmentObject var listVM: NewsListViewModel
    @State private var detaildedArticle: Article?
    @State private var openDetailed = false
    
    var body: some View{
        VStack{
            List(listVM.news) { item in
                Button(item.title ?? ""){
                    detaildedArticle = item
                    openDetailed = true
                }
            }
            .navigationTitle("News")
            NavigationLink(destination: DetailedView(details: detaildedArticle?.description).padding(.horizontal, 16.0), isActive: $openDetailed) { EmptyView() }
        }
    }
}

struct DetailedView: View{
    let details: String?
    @EnvironmentObject var listVM: NewsListViewModel
    
    var body: some View{
        ScrollView{
            Text(details ?? "")
            Button("Refresh parent list"){
                listVM.fetch(term: "Amazon")
            }
        }
    }
}


class NewsListViewModel: ObservableObject{
    
    internal init(api: NewsApi) {
        self.api = api
    }
    
    let api: NewsApi
    @Published var news = Array<Article>()
    var task: Task<Void, Error>?
    
    func fetch(term: String = ""){
        let checkedTerm = term.isEmpty ? "Apple" : term
        task?.cancel()
        task = Task{
            let result = try await api.news(term: checkedTerm).articles
            DispatchQueue.main.async {
                self.news = result
            }
        }
    }
}

class CurrentOpenNewsMode: ObservableObject{
    
}




























