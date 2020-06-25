//
// Helper.swift.
// Shopping.
// 

import Foundation
import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
class Helper: UIAlertController  {
//    public var str:String = ""
//    func initmessage() {
//
//        //self.present(alert)
//        self.present(alert, animated: true, completion: nil)
//        
//    }
    class func alert(msg:String, target: UIViewController) {
        let alert:UIAlertController = UIAlertController(title: "Shopping", message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .destructive) { (btn) in
            
        }
        alert.addAction(btnOK)

        target.present(alert, animated: true, completion: nil)
    }
    class func alertLogin(msg:String, target: UIViewController) {
        let alert:UIAlertController = UIAlertController(title: "Shopping", message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .destructive) { (btn) in
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            target.present(nav, animated: true, completion: nil)
        }
        let btnCanner:UIAlertAction = UIAlertAction(title: "Canner", style: .cancel){(btn) in
            
        }
        
        alert.addAction(btnOK)
        alert.addAction(btnCanner)
        target.present(alert, animated: true, completion: nil)
    }
}
