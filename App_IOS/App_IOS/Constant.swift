//
// Constant.swift.
// App_ios.
// 

import UIKit

enum SaveKey: String {
    case access_token
    case isLogin
    
    func toString() -> String {
        return self.rawValue
    }
}

class Constant: NSObject {
    
}
