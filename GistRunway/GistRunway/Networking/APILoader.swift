//
//  APILoader.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

//The APILoader can receive ANY request as long as it conforms to my precious apihandler
//Protocols are a really nice way to constrain some rules. Learned it not long ago.
class APILoader<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    //
    func loadAPIRequest(completionHandler: @escaping (Result<T.ResponseDataType, Error>) -> ()) {
        if let urlRequest = apiRequest.makeRequest() {
            
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return
                }

                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data, response: httpResponse)
                    completionHandler(.success(parsedResponse))
                } catch {
                    completionHandler(.failure(error))
                }
            }.resume()
        }
    }
}
