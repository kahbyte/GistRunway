//
//  ImageLoader.swift
//  GistRunway
//
//  Created by Kauê Sales on 28/09/21.
//

import Foundation
import UIKit

struct ImageLoader: APIHandler {
    var imageURL: String
    
    func makeRequest() -> URLRequest? {
        let urlString = imageURL
        
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }    

    func parseResponse(data: Data, response: HTTPURLResponse) throws -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}
