//
//  Created by Jake Lin on 9/8/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

struct SWError {
  enum Code: Int {
    case urlError                 = -6000
    case networkRequestFailed     = -6001
    case jsonSerializationFailed  = -6002
    case jsonParsingFailed        = -6003
  }

  let errorCode: Code
}
