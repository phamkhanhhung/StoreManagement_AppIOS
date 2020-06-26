//
//  LoginManager.swift
//  CashD
//
//  Created by Shapee Hoa on 1/9/20.
//  Copyright © 2020 Luy Nguyen. All rights reserved.
//

import Foundation

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
                completion(user)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
