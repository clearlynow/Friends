//
//  UserDetail.swift
//  Friends
//
//  Created by Alison Gorman on 11/4/22.
//

import SwiftUI

struct UserDetail: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var user: User
    
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
                    Text("Registered: \(user.formattedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Works for: \(user.company)")
                } header: {
                    Text("Basic Info")
                }
                
                Section {
                    Text(user.about)
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                } header: {
                    Text("Friends")
                }
            }
                }
                .navigationTitle(user.name)
                .navigationBarTitleDisplayMode(.inline)
            }
}

