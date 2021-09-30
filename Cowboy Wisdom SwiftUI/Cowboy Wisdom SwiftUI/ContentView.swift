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
    
    var body: some View {
        VStack {
            Spacer()
            Text(currentQuote ?? "Tap for wisdom…")
                .font(Font.custom("Baskerville", size: 24, relativeTo: .body))
                .bold()
                .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            Spacer(minLength: 20)
            Button("🤠🗯", action: getCowboyWisdom)
                .padding()
                .background(.blue)
                .border(.blue, width: 2)
                .cornerRadius(8.0)
        }
    }
    
    func getCowboyWisdom() {
        currentQuote = cowboyWisdomProvider.quotes.randomElement()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
