//
//  GameDetailesViewModel.swift
//  La3ebAssesment
//
//  Created by Sharaf on 25/05/2023.
//

import Foundation

struct GamesDetailsViewModel {
  
    var id:Int
    var isFavorite:Bool
    var gameDetail:((GameDetailModel?,Error?)->Void)?
    
    init(gameId: Int,isFavorite:Bool) {
        self.id = gameId
        self.isFavorite = isFavorite
       
    }
    
    func getAPIData( completion: @escaping (GameDetailModel?, ServiceError?) -> ()) {
        let request = GameDetailService(id: id)
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: [:]) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}


struct Sites {
    var name,link:String
}
