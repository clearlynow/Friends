//
//  UserDetail.swift
//  Friends
//
//  Created by Alison Gorman on 11/4/22.
//

import SwiftUI



struct UserDetail: View {
    @Environment(\.colorScheme) var colorScheme
    var user: CachedUser
    
    var body: some View {
        VStack{
            Text(user.nameInitials ?? "XX")
                            .font(.largeTitle)
                            .padding(60)
                            .background(colorScheme == .dark ? .black : .white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(user.isActive ? Color.green : Color.gray, lineWidth: 4)
                            )
                            .padding(20)
        
        
            List {
                Section {
                    Text("Registered: \(user.wrappedFormattedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.wrappedEmail)")
                    Text("Address: \(user.wrappedAddress)")
                    Text("Works for: \(user.wrappedCompany)")
                } header: {
                    Text("Basic Info")
                }
                
                Section {
                    Text(user.wrappedAbout)
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                    }
                } header: {
                    Text("Friends")
                }
            }
                }
                .navigationTitle(user.wrappedName)
                .navigationBarTitleDisplayMode(.inline)
            }
}

