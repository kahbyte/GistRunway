//
//  GistAPIResponse.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

struct Gist: Codable {
    var id: String
    var files: [String: FileDetails]?
    var description: String?
    var owner: Owner
    var comments: Int
    var comments_url: String
    var forks_url: String
}

struct FileDetails: Codable {
    var filename: String?
    var type: String?
    var language: String?
    var raw_url: String?
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

extension Gist {
    var fileList: [FileDetails]  {
        var fileList = [FileDetails]()

        files?.forEach { data in
            fileList.append(data.value)
        }

        return fileList
    }
}
