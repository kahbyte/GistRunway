//
//  GistAPIResponse.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

struct Gist: Codable {
    var id: String
    var description: String?
    var owner: Owner
    var comments: Int
    var comments_url: String
    var forks_url: String
}

struct Owner: Codable {
    var login: String
    var avatar_url: String
}

struct Comments: Codable {
    var user: User
    var body: String
}

struct User: Codable {
    var login: String
    var avatar_url: String
}

//I just want the quantity. 
struct Forks: Codable {
    
}
