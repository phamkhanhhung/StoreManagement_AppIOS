//
// UrlRequestExtention.swift.
// CashD.
// 

import Foundation
import Alamofire

extension URLRequest {
    static func createRequest(with path: String, _ method: HTTPMethod, _ array: [[String:Any]]?, _ parameters: Parameters?, _ headers: HTTPHeaders) throws -> URLRequest {
        // setting path
        let url = try path.asURL()
        var urlRequest: URLRequest = URLRequest(url: url)
        
        // setting method
        urlRequest.httpMethod = method.rawValue
    
        // setting header
        
        urlRequest.headers = headers
        let urlString = urlRequest.url?.absoluteString ?? "No url"
        print("----API SERVICE LOG----")
        print("- url: \(urlString)")
        print("- param: \(parameters ?? [:])")
        print("- array: \(array ?? [[:]])")
        print("- method: \(method.rawValue)")
        print("- headers: \(headers)")
        if let parameters = parameters {
            switch method {
            case .get:
                return try URLEncoding.default.encode(urlRequest, with: parameters)
            default:
                if path == "/oauth/access_token" {
                    return try URLEncoding.default.encode(urlRequest, with: parameters)
                }else{
                    return try JSONEncoding.default.encode(urlRequest, with: parameters)
                }
            }
        }
        
        if let ar = array {
            do {
                return try ArrayEncoding().encode(urlRequest, with: ar.asParameters())
            } catch {
                print(error)
                return urlRequest
            }
        }
        
        return urlRequest
    }
}

private let arrayParametersKey = "arrayParametersKey"

extension Array {
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}

public struct ArrayEncoding: ParameterEncoding {
    public let options: JSONSerialization.WritingOptions

    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        guard let parameters = parameters,
            let array = parameters[arrayParametersKey] else {
                return urlRequest
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            urlRequest.httpBody = data
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        return urlRequest
    }
}
