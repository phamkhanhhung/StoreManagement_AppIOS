//
//  CurrencyService.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class APIService: NSObject {
    static let shared = APIService()
    
    func login(username: String, pass: String, hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.login(username: username, pass: pass), hasProgress: hasProgress, completion: completion)
    }
    
    func signup(username: String, pass: String, hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.signup(username: username, pass: pass), hasProgress: hasProgress, completion: completion)
    }
    
    func getUser(hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.getUser, hasProgress: hasProgress, completion: completion)
    }
    
    func putUser(name:String, email:String,address:String, phoneNumber:String, gender:Bool, dateOfBirth:String, image:String, groupUserId:Int, hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.putUser(name: name, email: email, address: address, phoneNumber: phoneNumber, gender: gender, dateOfBirth: dateOfBirth, image: image, groupUserId: groupUserId), hasProgress: hasProgress, completion: completion)
    }
    
    func getBranch(hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.getBranch, hasProgress: hasProgress, completion: completion)
    }
    
    func getProductByBranchId(branchid:Int,hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.getProductByBranchId(branchid: branchid), hasProgress: hasProgress, completion: completion)
    }
    
    func postOrder(parameters:[String:Any],hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.postOrder(parameters: parameters), hasProgress: hasProgress, completion: completion)
    }
    func getOrderByUserId(Id:String, hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.getOrderByUserId(Id: Id), hasProgress: hasProgress, completion: completion)
    }
    func getOrderDetail(OrderId:String, hasProgress: Bool, _ completion: @escaping ((Result<JSON, AFError>) -> Void)) {
        WebServices.shared.request(APIRouter.getOrderDetail(OrderId: OrderId), hasProgress: hasProgress, completion: completion)
    }
}
