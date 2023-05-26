//
//  Favorites.swift
//  La3ebAssesment
//
//  Created by Sharaf on 26/05/2023.
//

import Foundation

class Favorites {
    static let shared = Favorites()
    var favorites:[GameDetailUIModel] = []
    
    func removeFromFavorites(id:Int,compeletion:((()->Void))?) {
        guard let index = favorites.firstIndex(where: {$0.id == id}) else {return}
        favorites.remove(at: index)
    }
    
}
