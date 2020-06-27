//
//  CountryApi.swift
//  TemplateProject
//
//  Created by Hoa on 6/28/19.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
enum APIRouter: URLRequestConvertible {
    static private let baseUrl = "http://52.77.233.77:8081/api/"
    static private let token = (Save.get(.access_token) as? String) ?? ""
    static private let idUser = (Save.get(.idlogin) as? Int) ?? 0
    
    case login(username: String, pass: String)
    case signup(username: String, pass: String)
    case getUser
    case putUser(name:String, email:String,address:String, phoneNumber:String, gender:Bool, dateOfBirth:String, image:String, groupUserId:Int)
    case getBranch
    case getProductByBranchId(branchid:Int)
    case postOrder(parameters:[String:Any])
    // MARK: - Path
    private var path: String {
        switch self {
        case .login: return "Auth/login"
        case .signup: return "Auth/register"
        case .getUser: return "User/" + String((Save.get(.idlogin) as? Int) ?? 0)
        case .putUser: return "User/" + String((Save.get(.idlogin) as? Int) ?? 0)
        case .getBranch: return "Branch?page=1&pagesize=100"
        case .getProductByBranchId(let branchid): return "Product/GetAllProductInBranch?BranchId=\(String(branchid))&page=1&pagesize=100"
        case .postOrder: return "Order"
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .signup: return .post
        case .getUser: return .get
        case .putUser: return .put
        case .getBranch:return .get
        case .getProductByBranchId: return .get
        case .postOrder: return .post
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let pass):
            return ["username" : username,
                    "password" : pass]
        case .signup(let username, let pass):
            return ["username" : username,
                    "password" : pass]
        case .getUser:
            return nil
        case .putUser(let name, let email, let address, let phoneNumber, let gender, let dateOfBirth, let image, let groupUserId):
            return ["name": name, "email": email, "address": address, "phoneNumber":phoneNumber,"gender": gender,  "dateOfBirth": dateOfBirth, "image": image, "groupUserId": groupUserId ]
        case .getBranch:
            return nil
        case .getProductByBranchId:
            return nil
        case .postOrder(let parameters):
            return parameters
        }
    }
    
    // MARK: - headers
    private var headers: HTTPHeaders {
        switch self {
        case .login:
            return [:]
        case .signup:
            return [:]
        case .getUser:
            return ["Authorization": "Bearer \(APIRouter.token)"]
        case .putUser:
            return ["Authorization": "Bearer \(APIRouter.token)"]
        case .getBranch:
            return [:]
        case .getProductByBranchId:
            return [:]
        case .postOrder:
            return ["Authorization": "Bearer \(APIRouter.token)"]
        }
        
    }
    
    // MARK: - EndPoint
    private var arrayParam: [[String: Any]]? {
        return nil
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try URLRequest.createRequest(with: APIRouter.baseUrl + path, method, arrayParam, parameters, headers)
    }
}
