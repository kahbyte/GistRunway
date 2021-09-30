//
//  GistAPI.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

struct GistAPI: APIHandler {
    let baseURL = "https://api.github.com"
    let path: Path
    let pageIndex: String = "0"
    
    func makeRequest() -> URLRequest? {
        let urlString = path.byPage
        
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [Gist] {
        return try defaultParseResponse(data: data,response: response)
    }
    
    enum Path {
        case getGists(page: Int)
        case getGistsFrom(user: String)
        
        var basePath: String {
            return "https://api.github.com/"
        }
        
        var byPage: String {
            switch self {
            case let .getGists(page):
                return basePath + "gists/public?page=\(page)"
            case let .getGistsFrom(user):
                return basePath + "users/\(user.lowercased())/gists"
            }
        }
    }
}
