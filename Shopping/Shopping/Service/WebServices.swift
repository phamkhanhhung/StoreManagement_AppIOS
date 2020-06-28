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
    
    func request(_ apiRouter: URLRequestConvertible, hasProgress: Bool, completion: @escaping (Result<JSON, AFError>) -> Void) {
        if !NetworkServices.isNetworkAvailable() {
            return
        }
        if hasProgress {
            KRProgressHUD.show()
        }
        AF.request(apiRouter).responseDecodable (decoder: JSONDecoder()) { (response: DataResponse<JSON, AFError>) in
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
