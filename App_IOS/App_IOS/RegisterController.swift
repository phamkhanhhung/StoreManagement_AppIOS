//
// RegisterController.swift.
// App_ios.
// 

import UIKit
import Alamofire
class RegisterController: UIViewController {

  
    @IBOutlet weak var txtCfPass: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
        
        let userr:String = "hung51"
        let passr:String = "12345678"
        let cfpassr:String = "12345678"
        if passr == cfpassr
        {
            var parameters1:[String:String]?
            parameters1 = ["username": userr as String,"password": passr]
            AF.request("http://52.77.233.77:8081/api/Auth/register", method: .post, parameters: parameters1,encoding: URLEncoding.default, headers: nil).responseJSON {
                    response in
            
                    switch response.result {
                        case .success:
                            if let dictSuccess:NSDictionary =  response.value as! NSDictionary?
                            {
                                let scr = self.storyboard?.instantiateViewController(withIdentifier: "Profire") as! ProfireController
                                //self.present(scr, animated: true, completion: nil)
                                self.navigationController?.pushViewController(scr, animated: true)
                                


                            }

                            break
                        case .failure(let error):

                            print(response)
                            print(error)
                        }

                    }
        }else
        {
            print("erro")
        }
    }
    
    
    

}
