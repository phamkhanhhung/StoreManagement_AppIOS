//
// LoginVC.swift.
// Shopping.
// 

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
import KRProgressHUD
class LoginVC: UIViewController {
    @IBOutlet weak var tfUsername: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPass: SkyFloatingLabelTextField!
    @IBOutlet weak var lbRegister: UILabel!
    
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
        
        self.dismiss(animated: true, completion: nil)

        
    }
    @IBAction func actionLogin(_ sender: Any) {
        KRProgressHUD.show()
        let user:String = tfUsername.text!
        let pass:String = tfPass.text!
        var parameters:[String:String]?
        parameters = ["username": user as String,"password":pass ]
        AF.request("http://52.77.233.77:8081/api/Auth/login", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
            KRProgressHUD.dismiss()
                switch response.result {
                    case .success:
                        if let value = response.value {
                            if let json = JSON(rawValue: value) {
                                let acc = json["access_token"].stringValue
                                let key = SaveKey.access_token.toString()
                                UserDefaults.standard.setValue(acc,forKey: key)
                                UserDefaults.standard.setValue(true,forKey: SaveKey.isLogin.toString())
                                let user = User(json: json["user"])
                                Data.shared.userLogin = user
                                
                                UserDefaults.standard.setValue(user.id, forKey: SaveKey.idlogin.toString())
                                
                                
                                
                                self.goProfile()
                                print(acc)
                            }
                        }

                        break
                    case .failure(let error):

                        print(response)
                        print(error)
                    }

                }
        
        
    }
    
    
    
    func goProfile()  {
                
                let app = UIApplication.shared.delegate as! AppDelegate
                app.tabVC?.selectedIndex = 2
                self.dismiss(animated: true, completion: nil)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginVC {
    func initUI() {
        lbRegister.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionRegister)))
        #if targetEnvironment(simulator)
        tfUsername.text = "admin"
        tfPass.text = "12345678"
        #endif
    }
    
    func initData() {
        
    }
    
    @objc func actionRegister() {
        
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

