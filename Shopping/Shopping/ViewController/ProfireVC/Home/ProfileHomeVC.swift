//
// ProfileHomeVC.swift.
// Shopping.
// 

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
class ProfileHomeVC: UIViewController ,UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegateFlowLayout{
    var item:[String]  = ["Account Setting","View Order History"]
    let avata:[UIImage] = [#imageLiteral(resourceName: "settingP"),#imageLiteral(resourceName: "vieworder")]
    
    @IBOutlet weak var btlogin: UIButton!
    @IBOutlet weak var tbvChoose: UITableView!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var imgAvata: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        tbvChoose.register(UINib.init(nibName: "PHCell", bundle: nil), forCellReuseIdentifier: "PHCell")
        tbvChoose.dataSource = self
        tbvChoose.delegate = self
        tbvChoose.separatorStyle = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
        initData()
        initUI()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
    @IBAction func actionLogout(_ sender: Any) {
                UserDefaults.standard.removeObject(forKey: SaveKey.access_token.toString())
                UserDefaults.standard.removeObject(forKey: SaveKey.isLogin.toString())
                UserDefaults.standard.removeObject(forKey: SaveKey.idlogin.toString())
        checkLogin()
        
    }
    
    func checkLogin() {
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            imgAvata.isHidden = false
            lbName.text = String(Data.shared.userProfile.name)
            btlogin.isHidden = true
        }else{
            imgAvata.isHidden = true
            lbName.text = ""
            btlogin.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PHCell", for: indexPath as IndexPath) as! PHCell
        cell.lbName.text = item[indexPath.row]
        cell.imgIcon.image = avata[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        if indexPath.row == 1 {
            let vc = OrderHistoryVC(nibName: "OrderHistoryVC", bundle: nil)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    func setTF() {
        lbName.isHidden = false
        lbName.text = String( Data.shared.userProfile.name )
        //lbName.text = "aefewfwef"
    }
    

}
extension ProfileHomeVC {
    func initUI() {
        
        
       // self.setTF()
        
        
    }
    
    func initData() {
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
            let urlrq:String = "http://52.77.233.77:8081/api/User/"+String(idstr)
            let token = UserDefaults.standard.value(forKey: SaveKey.access_token.toString()) as? String ?? ""
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            AF.request(urlrq, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
                    response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.value {
                            if let json = JSON(rawValue: value) {
                                Data.shared.userProfile = UserInformation()
                                let user = UserInformation(json: json)
                                Data.shared.userProfile = user
                                //self.lbName.text = String( user.name)
                                self.setTF()
                                
                                
                            }
                        }
                        
                        break
                    case .failure(let error):
                        
                        print(response)
                        print(error)
                    }
                    
                }
                
                
            }
        }
        
    
    
}
