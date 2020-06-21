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
        
        let nav = generateNavController(vc: HomeVC(), title: "Home", image: #imageLiteral(resourceName: "TB_Home1"))
        let nav1 = generateNavController(vc: OrderVC(), title: "Order", image: #imageLiteral(resourceName: "TB_Cart1"))
        let nav2 = generateNavController(vc: ProfileHomeVC(), title: "Profile", image: #imageLiteral(resourceName: "TB_Profile1"))
        
        UINavigationBar.appearance().prefersLargeTitles = false
        viewControllers = [nav,nav1,nav2]
        self.delegate = self
        
    }
    fileprivate func generateNavController(vc:UIViewController, title:String, image: UIImage) -> UINavigationController{
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
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
