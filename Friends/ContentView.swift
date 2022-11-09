//
//  ContentView.swift
//  Friends
//
//  Created by Alison Gorman on 11/4/22.
//
import Foundation
import SwiftUI

struct Response: Codable {
    var results: [User]
}

struct User: Codable, Identifiable {
    var id: String
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
    var id: String
    var name: String
}

struct ContentView: View {
    @State private var results = [User]()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach($results) { $user in
                    NavigationLink(destination: UserDetail(user: $user)) {
                        HStack {
                            Text(user.nameInitials ?? "XX")
                                .padding()
                                //.background(colorScheme == .dark ? .black : .white)
                                .clipShape(Circle())
                                .frame(width: 70)
                                .overlay(
                                    Circle()
                                        .stroke(user.isActive ? Color.green : Color.gray, lineWidth: 2)
                                )
                                .padding([.top, .bottom, .trailing], 5)
                            
                            VStack (alignment: .leading) {
                                Text(user.name).bold()
                                Text(user.isActive ? "Active" : "Offline").foregroundColor(user.isActive ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                if results.isEmpty {
                    print("loading data")
                    await loadData() }
            }
        }
    }
    
    func loadData() async {
        let stringURL = "https://www.hackingwithswift.com/samples/friendface.json"
        guard let url = URL(string: stringURL ) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("No data in response \(error?.localizedDescription ?? "No data response")")
                    return
                }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                            
                let decodedUsers = try decoder.decode([User].self, from: data)
                self.results = decodedUsers
            } catch let error {
                print("error: \(error)")
            }
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
