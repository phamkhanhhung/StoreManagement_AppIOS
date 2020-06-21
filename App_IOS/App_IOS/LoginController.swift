//
// LoginController.swift.
// App_ios.
// 

import UIKit
import Alamofire
import SwiftyJSON

enum GroupRole: String {
    case UnKnowk
    case Admin
}

class User: NSObject {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var groupRole: GroupRole = .UnKnowk
    
    override init() {
        
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        username = json["username"].stringValue
        email = json["email"].stringValue
        groupRole = GroupRole(rawValue: json["groupRole"].stringValue) ?? .UnKnowk
    }
}

class LoginController: UIViewController {

    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func btn_Login(_ sender: UIButton) {
        let user:String = txtUser.text!
        let pass:String = txtPass.text!
        var parameters:[String:String]?
        parameters = ["username": user as String,"password":pass ]
        AF.request("http://52.77.233.77:8081/api/Auth/login", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
        
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
                                self.goProfile()
                            }
                        }

                        break
                    case .failure(let error):

                        print(response)
                        print(error)
                    }

                }
    }
    
    func goProfile() {
        let scr = self.storyboard?.instantiateViewController(withIdentifier: "Profire") as! ProfireController
        //self.present(scr, animated: true, completion: nil)
        self.navigationController?.pushViewController(scr, animated: true)
    }
    

    @IBAction func btn_Register(_ sender: UIButton) {

    }
    
    

}
