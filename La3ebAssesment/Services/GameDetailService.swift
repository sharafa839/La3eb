//
//  GameDetail.swift
//  La3ebAssesment
//
//  Created by Sharaf on 26/05/2023.
//

import Foundation
struct GameDetailService:APIHandler {
    var id:Int
    init(id: Int) {
        self.id = id
    }
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        
        let urlString =  APIPath().games + "/\(id)"
        if var url = URL(string: urlString) {
            url = setQueryParams(parameters: param, url: url)
            
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> GameDetailModel {
        return try defaultParseResponse(data: data,response: response)
    }
    
    
}
