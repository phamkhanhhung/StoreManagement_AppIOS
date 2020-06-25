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
    var vBag: UIView = UIView()
    var lbCount: UILabel = UILabel()
    
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
            let xBag = UIScreen.main.bounds.width - 50 - 15;
            let yBag = UIScreen.main.bounds.height - 50 - 15 - (tabVC?.tabBar.frame.size.height ?? 0);
            vBag = UIView(frame: CGRect(x: xBag, y: yBag, width: 50, height: 50))
            vBag.backgroundColor = .clear
            vBag.shadowRadius = 5
            let vContent = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            vContent.backgroundColor = .white
            vContent.cornerRadius = 5
            vBag.addSubview(vContent)
            let imv = UIImageView(frame: CGRect(x: 15, y: 15, width: 20, height: 20))
            imv.contentMode = .scaleAspectFit
            imv.image = #imageLiteral(resourceName: "home_bag")
            vContent.addSubview(imv)
            lbCount = UILabel(frame: CGRect(x: 28, y: 28, width: 14, height: 14))
            lbCount.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            lbCount.text = ""
            lbCount.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            lbCount.cornerRadius = 2
            lbCount.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
            lbCount.textAlignment = .center
            vContent.addSubview(lbCount)
            wd.addSubview(vBag)
            vBag.isHidden = true
            vBag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openOrder)))
        }
    }
}

extension AppDelegate {
    @objc func openOrder() {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        window?.rootViewController?.topMostViewController?.present(nav, animated: true, completion: nil)
    }
}

extension UIViewController {
    var topPresentedViewController: UIViewController? {
        get {
            var target: UIViewController? = self
            while (target?.presentedViewController != nil) {
                target = target?.presentedViewController
            }
            return target
        }
    }
    
    var topVisibleViewController: UIViewController? {
        get {
            if let nav = self as? UINavigationController {
                return nav.topViewController?.topVisibleViewController
            }
            else if let tabBar = self as? UITabBarController {
                return tabBar.selectedViewController?.topVisibleViewController
            }
            return self
        }
    }
    
    var topMostViewController: UIViewController? {
        get {
            return self.topPresentedViewController?.topVisibleViewController
        }
    }
}

