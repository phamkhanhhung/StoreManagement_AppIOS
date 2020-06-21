//
// Product.swift.
// Shopping.
// 
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
class Product: NSObject {
    var id :Int = 0
    var name :String = ""
    var description0 : String = ""
    var price :Int = 0
    var discount :Int = 0
    var barcode :Int = 0
    var supplierName :String = ""
    var categoryName :String = ""
    var pictures: [Pictures] = []
    override init() {
        
    }
    init(json: JSON) {
        
        id = json["id"].intValue
        name = json["name"].stringValue
        description0 = json["description"].stringValue
        price = json["price"].intValue
        discount = json["discount"].intValue
        barcode = json["barcode"].intValue
        supplierName = json["supplierName"].stringValue
        categoryName = json["categoryName"].stringValue
        for js in json["pictures"].arrayValue {
            let pic = Pictures.init(json: js)
            pictures.append(pic)
        }
    }
}

