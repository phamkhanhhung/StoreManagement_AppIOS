//
// AppDelegate.swift.
// Shopping.
// 

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabVC: TabBarVC?
    
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
    }
}

