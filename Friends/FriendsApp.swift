//
//  FriendsApp.swift
//  Friends
//
//  Created by Alison Gorman on 11/4/22.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
