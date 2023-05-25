//
//  Observables.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
           listener?(value)
        }
    }
    
    private var listener : ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    func bind(_ clouser: @escaping (T) -> Void) {
        clouser(value)
        listener = clouser
    }
    
}
