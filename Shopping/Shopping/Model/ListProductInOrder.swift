//
// ListProductInOrder.swift.
// Shopping.
// 

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
class ListProductInOrder: NSObject {
    var quantity:Int = 0
    var picture:[Pictures] = []
    var price:Int = 0
    var productName:String = ""
    var customerName:String = ""
    var urlPictures: String = ""
    override init() {
        
    }
    init(json: JSON) {
        
        quantity = json["quantity"].intValue
        price = json["price"].intValue
        productName = json["productName"].stringValue
        customerName = json["customerName"].stringValue
        for js in json["picture"].arrayValue {
            let pic = Pictures.init(json: js)
            picture.append(pic)
        }
        
    }
    
    
}
