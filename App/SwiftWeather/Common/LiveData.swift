//
//  LiveData.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

/// `LiveData` is a data holder class that can be observed. It is a simplified version of Android Architecture component `LiveData`
class LiveData<T> {
    typealias Observer = (T) -> Void
    var observer: Observer?
    var value: T
    
    init(_ value: T) {
        self.value = value
    }

    func observe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
    func setValue(value: T) {
        self.value = value
        self.observer?(value)
    }
    
    func postValue(value: T) {
        self.value = value

        DispatchQueue.main.async(execute: { [unowned self, value] in
            self.observer?(value)
        })
    }
}
