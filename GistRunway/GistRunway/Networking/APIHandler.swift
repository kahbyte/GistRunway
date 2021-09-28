//
//  APIHandler.swift
//  GistRunway
//
//  Created by Kauê Sales on 27/09/21.
//

import Foundation

//Created to specify the method. We won't be using any of those but the get method.
//Just wanted to show that the project can scale
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


protocol RequestHandler {
    func makeRequest() -> URLRequest?
}

//This one is going to have a default implementation in another file
protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

//Any api handler will be both a request and a response handler as well.
typealias APIHandler = RequestHandler & ResponseHandler
