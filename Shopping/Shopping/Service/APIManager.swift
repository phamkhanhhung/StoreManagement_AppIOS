//
//  LoginManager.swift
//  CashD
//
//  Created by Shapee Hoa on 1/9/20.
//  Copyright © 2020 Luy Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIManager: NSObject {
    static let shared = APIManager()
    
    func login(username: String, pass: String, progress: Bool, _ completion: @escaping ((User) -> Void)) {
        APIService.shared.login(username: username, pass: pass, hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                let acc = json["access_token"].stringValue
                let user = User(json: json["user"])
                Data.shared.userLogin = user
                Save.save(acc, key: .access_token)
                Save.save(true, key: .isLogin)
                Save.save(user.id, key: .idlogin)
                Save.save(username, key: .lgUserName)
                Save.save(pass, key: .lgPass)
                completion(user)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    func signup(username: String, pass: String, progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.signup(username: username, pass: pass, hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
            
                let acc = json["message"].boolValue
                completion(acc)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                break
            }
        }
    }
    func getUser(progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.getUser(hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                Data.shared.userProfile = UserInformation()
                let user = UserInformation(json: json)
                Data.shared.userProfile = user
                completion(true)
                break
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
                break
            }
        }
    }
    func putUser(name:String, email:String,address:String, phoneNumber:String, gender:Bool, dateOfBirth:String, image:String, groupUserId:Int, progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.putUser(name: name, email: email, address: address, phoneNumber: phoneNumber, gender: gender, dateOfBirth: dateOfBirth, image: image, groupUserId: groupUserId, hasProgress: progress){ (result) in
            switch result {
            case .success(let json):
            
                let acc = json["message"].boolValue
                
                completion(acc)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(true)
                break
            }
        }
    }
    func getBranch(progress: Bool, _ completion: @escaping ((Branch) -> Void)) {
        APIService.shared.getBranch(hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
            
                for js in json["items"].arrayValue {
                    let pro = Branch.init(json: js)
                    Data.shared.branch.append(pro)
                }
                completion(Data.shared.branch.first ?? Branch())
                break
            case .failure(let error):
                completion(Branch())
                print(error.localizedDescription)
                break
            }
        }
    }
    func getProductByBranchId(branchid: Int, progress: Bool, _ completion: @escaping ((JSON) -> Void)) {
        APIService.shared.getProductByBranchId(branchid: branchid, hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                
                completion(json)
                break
            case .failure(let error):
                completion(JSON.null)
                print(error.localizedDescription)
                break
            }
        }
    }
    func postOrder(parameters:[String:Any], progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.postOrder(parameters: parameters,hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                let message = json["message"].boolValue
                completion(message)
                break
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
                break
            }
        }
    }
    func getOrderByUserId(Id: String, progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.getOrderByUserId(Id: Id, hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                Data.shared.orderHistory.removeAll()
                for js in json["items"].arrayValue {
                    let oh = OrderHistory.init(json: js)
                    Data.shared.orderHistory.append(oh)
                }
                completion(true)
                break
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
                break
            }
        }
    }
    func getOrderDetail(OrderId: String, progress: Bool, _ completion: @escaping ((Bool) -> Void)) {
        APIService.shared.getOrderDetail(OrderId: OrderId, hasProgress: progress) { (result) in
            switch result {
            case .success(let json):
                Data.shared.listProductInOrder = []
                for js in json["items"].arrayValue {
                    let oh = ListProductInOrder.init(json: js)
                    Data.shared.listProductInOrder.append(oh)
                }
                completion(true)
                break
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
                break
            }
        }
    }

}
