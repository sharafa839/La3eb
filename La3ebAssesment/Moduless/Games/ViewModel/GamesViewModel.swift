//
//  GamesViewModel.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation
class GamesViewModel {
    var isLoading = false
     func getAPIData(param: [String: Any], completion: @escaping (GameModel?, ServiceError?) -> ()) {
        isLoading = true
        let request = GameService()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) {[weak self] (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
               
                completion(model, nil)
                self?.isLoading = false
            }
        }
    }
    
    
}
