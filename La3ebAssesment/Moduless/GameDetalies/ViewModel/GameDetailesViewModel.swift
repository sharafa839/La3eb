//
//  GameDetailesViewModel.swift
//  La3ebAssesment
//
//  Created by Sharaf on 25/05/2023.
//

import Foundation

struct GamesDetailsViewModel {
  
    var id:String
    init(gameId: String) {
        self.id = gameId
       
    }
    
    func getAPIData(param: [String: Any], completion: @escaping (GameModel?, ServiceError?) -> ()) {
        let request = Services()
        
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

