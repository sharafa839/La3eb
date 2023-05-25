//
//  ApiPath.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation


#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var games: String { return "\(baseURL)/games"}
    var favorites:String  { return "\(baseURL)/search/photos"}

}

