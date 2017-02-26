//
//  Created by Jake Lin on 8/27/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

class Observable<T> {
  typealias Observer = (T) -> Void
  var observer: Observer?

  func observe(_ observer: Observer?) {
    self.observer = observer
    observer?(value)
  }

  var value: T {
    didSet {
      observer?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }
}
