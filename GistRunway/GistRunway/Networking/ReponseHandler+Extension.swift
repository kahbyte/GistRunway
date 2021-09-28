//
//  ReponseHandler+Extension.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
}


//default implementation to the func in the protocol. By definition, this is how mostly jsons are parsed. ALSO EXTENSIONS TO PROTOCOLS, WHO WOULD HAVE IMAGINED? 🤯
extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T  {
        let jsonDecoder = JSONDecoder()
        
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch {
            print(error)
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
    }
}
