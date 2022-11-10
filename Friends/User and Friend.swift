//
//  User.swift
//  Friends
//
//  Created by Alison Gorman on 11/9/22.
//

import Foundation


struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int
    var email: String
    var about: String
    var company: String
    var isActive: Bool
    var address: String
    var registered: Date
    var friends: [Friend]
    
    var nameInitials: String? {
            if let range = name.range(of: " ") {
                let initials = name[range.upperBound...]
                let lastNameInitial = String(initials.prefix(1))
                let firstNameInitial = name.prefix(1)
                return "\(firstNameInitial)\(lastNameInitial)"
            }
            return "XX"
        }
    
    
    var formattedDate: String {
            registered.formatted(date: .abbreviated, time: .omitted)
        }
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
