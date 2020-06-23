//
// TabBarVC.swift.
// Shopping.
// 

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = generateNavController(vc: HomeVC(), title: "Home", image: #imageLiteral(resourceName: "tab_home"), selectedImage: #imageLiteral(resourceName: "tab_home_sl"))
        let nav1 = generateNavController(vc: OrderVC(), title: "Order", image: #imageLiteral(resourceName: "tab_order"), selectedImage: #imageLiteral(resourceName: "tab_order_sl"))
        let nav2 = generateNavController(vc: ProfileHomeVC(), title: "Profile", image: #imageLiteral(resourceName: "tab_profile"), selectedImage: #imageLiteral(resourceName: "tab_profile_sl"))
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.3882352941, alpha: 1)
        UINavigationBar.appearance().prefersLargeTitles = false
        viewControllers = [nav,nav1,nav2]
        self.delegate = self
        
    }
    fileprivate func generateNavController(vc:UIViewController, title:String, image: UIImage, selectedImage: UIImage) -> UINavigationController{
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        return navController
        
    }
}

extension TabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isLogin = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        //var hasToken: Bool = false
        
       
        if let nav = viewController as? UINavigationController {
            if let vc = nav.viewControllers.last, vc is ProfileVC {
                if !isLogin {
                    let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                    let nav = UINavigationController(rootViewController: vc)
                    self.present(nav, animated: true, completion: nil)
                }
                return isLogin
            }
        }
        return true
    }
}
