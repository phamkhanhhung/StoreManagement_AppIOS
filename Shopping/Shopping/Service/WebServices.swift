//
// MGConnection.swift.
// NewAPIService.
// 

import Foundation
import KRProgressHUD
import SwiftyJSON
import Alamofire

class WebServices: NSObject {
    static let shared = WebServices()
    
    func request<T:Decodable>(_ apiRouter: URLRequestConvertible, hasProgress: Bool, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) {
        if !NetworkServices.isNetworkAvailable() {
            return
        }
        if hasProgress {
            KRProgressHUD.show()
        }
        AF.request(apiRouter).responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
            if hasProgress {
                KRProgressHUD.dismiss()
            }
            guard let data = response.data else {
                return
            }
            let json = JSON(data)
            print("- result: \(json)")
            completion(response.result)
        }
    }
}
