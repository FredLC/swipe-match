//
//  Bindable.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-26.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
