//
//  ContentView.swift
//  Cowboy Wisdom SwiftUI
//
//  Created by Aaron London on 9/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cowboyWisdomProvider: CowboyWisdomProvider
    @State var currentQuote: String?
    @State private var searchText: String = ""
    @State var searchResults: [SearchResult] = []
    @State var didSearch = false
    
    var body: some View {
        TabView {
            VStack {
                Spacer()
                Text(currentQuote ?? "Tap for wisdom…")
                    .cowboyStyle()
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
                Spacer(minLength: 20)
                Button("🤠🗯", action: getCowboyWisdom)
                    .padding()
                    .background(.blue)
                    .border(.blue, width: 2)
                    .cornerRadius(8.0)
            }
            .tabItem {
                Text("🤠 Tap for wisdom")
            }
            VStack(alignment: .leading) {
                TextField("Search for cowboy wisdom…", text: $searchText, onCommit: {
                    guard !searchText.isEmpty else { return }
                    search(searchText)
                })
                    .cowboyStyle()
                    .modifier(TextFieldClearButton(text: $searchText, didSearch: $didSearch, searchResults: $searchResults))
                    .padding()
                Spacer(minLength: 20)
                ScrollView {
                    if !searchResults.isEmpty {
                        ForEach(searchResults) { result in
                            Text(result.result).cowboyStyle().padding()
                        }
                    } else if didSearch {
                        Text("Sorry stranger but we're fresh out of wisdom…").cowboyStyle().padding()
                    }
                }
            }
            .tabItem {
                Text("🔎 Search for wisdom").cowboyStyle()
            }
        }
    }
    
    func getCowboyWisdom() {
        currentQuote = cowboyWisdomProvider.quotes.randomElement()
    }
    
    func search(_ text: String) {
        didSearch = true
        searchResults = cowboyWisdomProvider.quotes.filter { $0.lowercased().contains(text.lowercased()) }.map { SearchResult(result: $0) }
    }
}

struct CowboyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Baskerville", size: 24, relativeTo: .body).bold())
    }
}

extension View {
    func cowboyStyle() -> some View {
        modifier(CowboyText())
    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    @Binding var didSearch: Bool
    @Binding var searchResults: [SearchResult]
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: {
                        self.text = ""
                        self.didSearch = false
                        self.searchResults = []
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct SearchResult: Identifiable {
    typealias ID = String
    var id: String {
        result
    }
    let result: String
}

struct ContentView_Previews: PreviewProvider {
    @State static var searchText = "horse"
    static var previews: some View {
        ContentView()
    }
}
