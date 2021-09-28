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
}

struct Owner: Codable {
    var login: String
    var avatar_url: String
}

