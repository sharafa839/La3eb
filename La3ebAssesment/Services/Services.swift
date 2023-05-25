//
//  GamesServices.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation
struct Services:APIHandler {
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().games
            if var url = URL(string: urlString) {
                if param.count > 0 {
                    url = setQueryParams(parameters: param, url: url)
                }
                var urlRequest = URLRequest(url: url)
                setDefaultHeaders(request: &urlRequest)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                return urlRequest
            }
            return nil
        }
        
        func parseResponse(data: Data, response: HTTPURLResponse) throws -> GameModel {
            return try defaultParseResponse(data: data,response: response)
        }
    
    
}
