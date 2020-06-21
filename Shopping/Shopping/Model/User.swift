//
// User.swift.
// Shopping.
// 

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class User: NSObject {
    var id:Int = 0
    var username: String = ""
    var email: String = ""
    var groupRole: GroupRole = .UnKnowk

        override init() {

        }

        init(json: JSON) {
            id = json["id"].intValue
            username = json["username"].stringValue
            email = json["email"].stringValue
            groupRole = GroupRole(rawValue: json["groupRole"].stringValue) ?? .UnKnowk
        }


}
