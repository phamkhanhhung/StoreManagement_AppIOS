//
// Pictures.swift.
// Shopping.
// 

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
class Pictures: NSObject{
    var id:Int = 0
    var imageUrl:String = ""
    var productId:String = ""
    override init() {
    }
    init(json: JSON) {
        id = json["id"].intValue
        imageUrl = json["imageUrl"].stringValue
        productId = json["productId"].stringValue
    }
}
