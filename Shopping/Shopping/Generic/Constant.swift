//
// Constant.swift.
// Shopping.
// 

import Foundation
import UIKit
enum SaveKey: String {
    case access_token
    case isLogin
    case idlogin
    func toString() -> String {
        return self.rawValue
    }
}

enum SaveID:Int {
    case idlogin
    func tostring() -> String {
        return String( self.rawValue)
    }
}

enum GroupRole: String {
    case UnKnowk
    case Admin
    case Customer
}

class Constant: NSObject {
    
}
