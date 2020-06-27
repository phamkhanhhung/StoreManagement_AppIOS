//
// ProfileHomeVC.swift.
// Shopping.
// 

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
import Kingfisher
import KRProgressHUD
class ProfileHomeVC: UIViewController ,UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegateFlowLayout{
    var item:[String]  = ["Account Setting","Log Out"]
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
    
    
    func checkLogin() {
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
//            imgAvata.isHidden = false
            lbName.text = String(Data.shared.userProfile.name)
            btlogin.isHidden = true
        }else{
//            imgAvata.isHidden = true
            lbName.text = ""
            btlogin.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PHCell", for: indexPath as IndexPath) as! PHCell
        cell.lbName.text = item[indexPath.row]
        cell.imgIcon.image = avata[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            if indexPath.row == 0{
                // edit profile
                let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
//                let nav = UINavigationController(rootViewController: vc)
//                nav.modalPresentationStyle = .fullScreen
//                self.present(nav, animated: true, completion: nil)
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            if indexPath.row == 1 {
                //log out
                UserDefaults.standard.removeObject(forKey: SaveKey.access_token.toString())
                UserDefaults.standard.removeObject(forKey: SaveKey.isLogin.toString())
                UserDefaults.standard.removeObject(forKey: SaveKey.idlogin.toString())
                Data.shared.orderHistory.removeAll()
//                Data.shared.oderProduct.removeAll()
                checkLogin()
                tableView.reloadData()
            }
        }else{
            Helper.alertLogin(msg: "Please log in!", target: self)
        }
        
    }
    func setTF() {
        lbName.isHidden = false
        lbName.text = String( Data.shared.userProfile.username )
        //lbName.text = "aefewfwef"
    }
    
    
}
extension ProfileHomeVC {
    func initUI() {
        
        
        // self.setTF()
        self.tbvChoose.reloadData()
        if !(Data.shared.userProfile.image.count <= 0){
            self.imgAvata.kf.setImage(with: URL(string: Data.shared.userProfile.image), placeholder: UIImage(named: "noavata"), options: [], progressBlock: { (a, b) in
                
            }) { (result) in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func initData() {
        let isLogin:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin.toString()) as? Bool ?? false
        if isLogin {
            KRProgressHUD.show()
            let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
            let urlrq:String = "http://52.77.233.77:8081/api/User/"+String(idstr)
            let token = UserDefaults.standard.value(forKey: SaveKey.access_token.toString()) as? String ?? ""
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            AF.request(urlrq, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                KRProgressHUD.dismiss()
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
