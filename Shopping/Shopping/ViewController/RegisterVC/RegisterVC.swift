//
// RegisterVC.swift.
// Shopping.
// 

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
class RegisterVC: UIViewController {
    
    
    @IBOutlet weak var tfUsername: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPass: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tfConfPass: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func actionDone(_ sender: Any) {
        
        
        //self.navigationController?.popViewController(animated: true)
        if isValid() {
            
            let user:String = tfUsername.text!
            let pass:String = tfPass.text!
            var parameters:[String:String]?
            parameters = ["username": user as String,"password":pass ]
            AF.request("http://52.77.233.77:8081/api/Auth/register", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                
                switch response.result {
                    
                    
                case .success:
                    self.navigationController?.popViewController(animated: true)
                    self.gotoLogin()
                    
                    
                    break
                case .failure(let error):
                    print(response.result)
                    self.gotoLogin()
                    
                    
                    
                }
                
            }
            
            
            
        }
    }
    func gotoLogin()  {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
extension RegisterVC {
    func initUI() {
        
        #if targetEnvironment(simulator)
        tfUsername.text = "hung6"
        tfPass.text = "12345678"
        tfConfPass.text = tfPass.text
        #endif
    }
    
    func initData() {
        
    }
    
    func isValid() -> Bool {
        if tfUsername.text?.count == 0 {
            
            Helper.alert(msg: "Username can't be blank. Please try again later", target: self)
            
            return false
        }
        if tfPass.text?.count == 0 {
            
            Helper.alert(msg: "Password can't be blank. Please try again later", target: self)
            
            
            
            return false
        }
        if tfConfPass.text != tfPass.text {
            Helper.alert(msg: "Your Password and Confirm Password do not match. Please try again later", target: self)
            
            
            return false
        }
        return true
    }
}



