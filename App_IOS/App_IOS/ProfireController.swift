//
// ProfireController.swift.
// App_ios.
// 

import UIKit

class ProfireController: UIViewController {

    var skm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: SaveKey.isLogin.toString())
        UserDefaults.standard.removeObject(forKey: SaveKey.access_token.toString())
    }
}
