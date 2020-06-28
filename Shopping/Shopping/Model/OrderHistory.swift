//
// OrderHistory.swift.
// Shopping.
// 

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
class OrderHistory: NSObject {
    var id:Int = 0
    var staffId:Int = 0
    var staffName:String = ""
    var customerId:Int = 0
    var customerName:String = ""
    var orderDate:Date = Date()
    var status: Bool = false
    var code:Int = 0
    var totalPrice:Int = 0
    override init() {
        
    }
    
    init(json: JSON) {
        
        id = json["id"].intValue
        staffId = json["staffId"].intValue
        customerId = json["customerId"].intValue
        code = json["code"].intValue
        totalPrice = json["totalPrice"].intValue
        status = json["status"].boolValue
        staffName = json["staffName"].stringValue
        customerName = json["customerName"].stringValue
        
        let datestr = json["orderDate"].stringValue
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        dateFor.locale = Locale(identifier: "vi")
        self.orderDate = dateFor.date(from: datestr) ?? Date()
    }
}
