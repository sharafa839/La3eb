//
//  RequestHandlerEX.swift
//  La3ebAssesment
//
//  Created by Sharaf on 23/05/2023.
//

import Foundation
import Foundation
// MARK: Request Handler Supporting methods

extension RequestHandler {
    
    func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var param = parameters
        param[Constants.APIHeaders.apiKey] = Constants.APIHeaders.apiKeyValue
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = param.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(Constants.APIHeaders.apiKey, forHTTPHeaderField: Constants.APIHeaders.apiKeyValue)
    }
}
