//
// UserInformation.swift.
// Shopping.
// 

import Foundation
import Alamofire
import UIKit
import SwiftyJSON
class UserInformation: NSObject {
    var id:Int = 0
    var username:String = ""
    var name:String = ""
    var email:String = ""
    var address:String = ""
    var phoneNumber:String = ""
    var gender:Bool = true
    var image:String = ""
    var groupRole:GroupRole = .UnKnowk
    
    var dateOfBirth: Date = Date()
    
    override init() {
        
    }
    
    init(json: JSON) {
        
        id = json["id"].intValue
        username = json["username"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        address = json["address"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        gender = json["gender"].boolValue
        image = json["image"].stringValue
        groupRole = GroupRole(rawValue: json["groupRole"].stringValue) ?? .UnKnowk
        let datestr = json["dateOfBirth"].stringValue
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFor.locale = Locale(identifier: "vi")
        dateOfBirth = dateFor.date(from: datestr) ?? Date()
        print(dateOfBirth.toString())
    }
    
    
    
    
}

extension Date {
    func toString(_ format: String = "dd/MM/yyyy") -> String {
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = format
        dateFor.locale = Locale(identifier: "vi")
        return dateFor.string(from: self)
    }
}

