//
//  CowboyWisdomProvider.swift
//  Cowboy Wisdom SwiftUI
//
//  Created by Aaron London on 9/29/21.
//

import UIKit

class CowboyWisdomProvider: ObservableObject {
    @Published private(set) var quotes = [String]()
    
    init() {
        guard let data = NSDataAsset(name: "cowboy-wisdom")?.data, let quotes = try? JSONDecoder().decode([String].self, from: data) else {
            quotes = ["Sometimes you unwrap the optional, and sometimes the optional unwraps you."]
            return
        }
        self.quotes = quotes
    }
}
