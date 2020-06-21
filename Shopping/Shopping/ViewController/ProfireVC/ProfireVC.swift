//
// ProfireVC.swift.
// Shopping.
// 

import UIKit

class ProfireVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func actionLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: SaveKey.isLogin.toString())
        UserDefaults.standard.removeObject(forKey: SaveKey.access_token.toString())
        
    }
    
   
    

}
 