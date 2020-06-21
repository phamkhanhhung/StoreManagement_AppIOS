//
// Branch.swift.
// Shopping.
// 

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
class Branch: NSObject {
    var id:Int = 0
    var description0:String = ""
    var phoneNumber:String = ""
    var address:String = ""
    override init() {
        
    }
    init(json : JSON ) {
        id = json["id"].intValue
        description0 = json["description"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        address = json["address"].stringValue
    }
}
