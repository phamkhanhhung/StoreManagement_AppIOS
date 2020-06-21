//
// ViewController.swift.
// App_ios.
// 

import UIKit
import Alamofire
class ViewController: UIViewController {

    
    override func viewDidLoad() {

        
    }
    
    @IBAction func btn_login(_ sender: UIButton) {
        
    }
    @IBAction func btn_Profire(_ sender: Any) {
        let isLogin = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            self.goProfile()
        } else {
            performSegue(withIdentifier: "go_login", sender: nil)
        }
    }
    
    @IBAction func btn_Home(_ sender: Any) {
        goHome()
    }
    @IBAction func btn_Oder(_ sender: Any) {
    }
    func goProfile() {
        let scr = self.storyboard?.instantiateViewController(withIdentifier: "Profire") as! ProfireController
        //self.present(scr, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(scr, animated: true)
    }
    func goHome() {
        let scr = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! ViewController
        //self.present(scr, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(scr, animated: true)
    }
}

