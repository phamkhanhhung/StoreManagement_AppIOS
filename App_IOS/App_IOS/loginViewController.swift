//
// loginViewController.swift.
// App_ios.
// 

import UIKit
import Alamofire
class loginViewController: UIViewController {

    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var txtuser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
                let user:String = txtuser.text!
                let pass:String = txtpass.text!
                        var parameters:[String:String]?
                        parameters = ["username": user as String,"password":pass ]
                        AF.request("http://52.77.233.77:8081/api/Auth/login", method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil).responseJSON {
                            response in
        
                            switch response.result {
                            case .success:
                                if let dictSuccess:NSDictionary =  response.value as! NSDictionary?
                                {
                                    print("ok")
        
        
                                   }
        
                                break
                            case .failure(let error):
        
                                print(response)
                                print(error)
                            }
        
                        }
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
    }
    
//    @IBAction func btn_dangnhap(_ sender: UIButton) {
//        let user:String = "txtuser.text!"
//        let pass:String = "txtpass.text!"
//                var parameters:[String:String]?
//                parameters = ["username": user as String,"password":pass ]
//                AF.request("http://52.77.233.77:8081/api/Auth/login", method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil).responseJSON {
//                    response in
//        
//                    switch response.result {
//                    case .success:
//                        if let dictSuccess:NSDictionary =  response.value as! NSDictionary?
//                        {
//                            print("ok")
//        
//        
//                           }
//        
//                        break
//                    case .failure(let error):
//        
//                        print(response)
//                        print(error)
//                    }
//        
//                }
//    }
    
    

}
