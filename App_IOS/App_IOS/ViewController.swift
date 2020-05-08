//
// ViewController.swift.
// App_IOS.
// 

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webServiceLogin(isFbLogin: true, email: "admin", password: "12345678")

        
    }
    func webServiceLogin(isFbLogin:Bool,email:String,password:String)
       {
           var parameters:[String:String]?

            parameters = ["username":email as String,"password":password ]

           
           AF.request("http://52.77.233.77:8081/api/Auth/login", method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil).responseJSON {
               response in
              
               switch response.result {
               case .success:
                   if let dictSuccess:NSDictionary =  response.value as! NSDictionary?
                   {
                    print(dictSuccess)
                        
                      }

                   break
               case .failure(let error):
                   
                   print(response)
                   print(error)
               }

           }
       }


}

