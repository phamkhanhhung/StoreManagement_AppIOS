//
//  CountryApi.swift
//  TemplateProject
//
//  Created by Hoa on 6/28/19.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    static private let baseUrl = "http://52.77.233.77:8081/api/"
    static private let token = (Save.get(.access_token) as? String) ?? ""
    
    case login(username: String, pass: String)
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login: return "Auth/login"
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let pass):
            return ["username" : username,
                    "password" : pass]
        }
    }
    
    // MARK: - headers
    private var headers: HTTPHeaders {
        switch self {
        case .login:
            return [:]
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
