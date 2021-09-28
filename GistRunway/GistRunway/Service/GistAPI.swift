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
    
    func makeRequest() -> URLRequest? {
        let urlString = baseURL.appending(path.rawValue)
        
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
    
    enum Path: String {
        case base = ""
        case gists =  "/gists"
    }
}
