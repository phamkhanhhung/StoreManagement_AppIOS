//
// Data.swift.
// Shopping.
// 

import Foundation
import UIKit

class Data: NSObject {
    static let shared = Data()    
    var userLogin: User = User()
    var userProfile: UserInformation = UserInformation()
    var product: [Product] = []
    var totalProduct:Int = 0
    var oderProduct: [OrderProduct] = []
    var branch:[Branch] = []
    var orderHistory:[OrderHistory] = []
    var listProductInOrder:[ListProductInOrder] = []
}
