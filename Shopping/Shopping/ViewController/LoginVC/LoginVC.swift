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
//        KRProgressHUD.show()
        let user:String = tfUsername.text!
        let pass:String = tfPass.text!
        APIManager.shared.login(username: user, pass: pass, progress: true) { (user) in
            self.goProfile()
        }
    }
    
    
    
    func goProfile()  {
        //
        //                let app = UIApplication.shared.delegate as! AppDelegate
        //                app.tabVC?.selectedIndex = 2
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginVC {
    func initUI() {
        lbRegister.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionRegister)))
        if let user:String = ((Save.get(.lgUserName) as? String)),user.count == 0 {
            tfUsername.text =  "admin"
            tfPass.text =  "12345678"
        }else{
            tfUsername.text =  ((Save.get(.lgUserName) as? String)) ?? "admin"
            tfPass.text = ((Save.get(.lgPass) as? String)) ?? "12345678"
        }
        
    }
    
    func initData() {
        
    }
    
    @objc func actionRegister() {
        
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

