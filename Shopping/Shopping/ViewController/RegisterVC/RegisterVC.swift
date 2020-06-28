//
// RegisterVC.swift.
// Shopping.
// 

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
import KRProgressHUD
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
        AppDel.hidenBag = true
        Data.shared.reloadBag()
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDel.hidenBag = false
        Data.shared.reloadBag()
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func actionDone(_ sender: Any) {
        if isValid() {
            let user:String = tfUsername.text!
            let pass:String = tfPass.text!
            APIManager.shared.signup(username: user, pass: pass, progress: true) { (status) in
                if status {
                    Helper.alertSignUp(msg: "Sign up success, Please login!", target: self)
                }else{
                    Helper.alert(msg: "Your user name is duplicate. Please sign up again!", target: self)
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



