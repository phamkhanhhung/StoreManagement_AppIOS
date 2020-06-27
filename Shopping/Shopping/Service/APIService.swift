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
}
