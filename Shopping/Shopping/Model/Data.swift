//
// Data.swift.
// Shopping.
// 

import Foundation
import UIKit

let AppDel = UIApplication.shared.delegate as! AppDelegate

class Data: NSObject {
    static let shared = Data()
    
    var userLogin: User = User()
    var userProfile: UserInformation = UserInformation()
    var product: [Product] = []
    var totalProduct:Int = 0
    var oderProduct: [OrderProduct] = [] {
        didSet {
            AppDel.vBag.isHidden = oderProduct.count == 0
            AppDel.lbCount.text = String(oderProduct.count)
        }
    }
    var branch:[Branch] = []
    var orderHistory:[OrderHistory] = []
    var listProductInOrder:[ListProductInOrder] = []
}
