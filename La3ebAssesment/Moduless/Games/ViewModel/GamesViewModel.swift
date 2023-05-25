//
//  GamesViewModel.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation
struct GamesViewModel {
    func getAPIData(param: [String: Any], completion: @escaping (GameModel?, ServiceError?) -> ()) {
        let request = GamesServices()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
    
    
}
