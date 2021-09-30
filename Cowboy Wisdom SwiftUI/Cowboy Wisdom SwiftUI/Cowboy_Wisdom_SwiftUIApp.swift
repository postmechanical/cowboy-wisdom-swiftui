//
//  Cowboy_Wisdom_SwiftUIApp.swift
//  Cowboy Wisdom SwiftUI
//
//  Created by Aaron London on 9/29/21.
//

import SwiftUI

@main
struct Cowboy_Wisdom_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CowboyWisdomProvider())
        }
    }
}
