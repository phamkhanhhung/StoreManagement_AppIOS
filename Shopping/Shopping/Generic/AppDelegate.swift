//
// AppDelegate.swift.
// Shopping.
// 

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //Branch hung
    var window: UIWindow?
    var tabVC: TabBarVC?
    var vBag: UIView = UIView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.3882352941, alpha: 1)
        setupRootVC()
        return true
    }

    func setupRootVC() {
//        let vcL = ProfileHomeVC(nibName: "ProfileHomeVC", bundle: nil)
//        let vcR = RegisterVC(nibName: "RegisterVC", bundle: nil)
      
        tabVC = TabBarVC(nibName: "TabBarVC", bundle: nil)
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
        if let wd = window {
            vBag = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
            vBag.backgroundColor = .red
            wd.addSubview(vBag)
            vBag.isHidden = true
        }
    }
}

