//
// OrderVC.swift.
// Shopping.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class OrderVC: UIViewController{
    @IBOutlet weak var tbMain: UITableView!
    
    @IBOutlet weak var lbTotalPrice: UILabel!
    var total:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Shopping Cart"
        tbMain.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confixData()
        setupNav()
    }
    
    func setupNav() {
        let right = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showBranch))
        self.navigationItem.leftBarButtonItem = right
    }
    
    @objc func showBranch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOrderProduct(_ sender: Any) {
        let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
        if idstr != 0 && Data.shared.oderProduct.count > 0 {
            KRProgressHUD.show()
            var orderDetail: [[String: Any]] = []
            for obj in Data.shared.oderProduct {
                let param: [String: Any] = ["quantity": obj.SoLuong, "disCount": 1, "productId": obj.product.id]
                orderDetail.append(param)
            }
            let parameters: [String:Any] = ["staffId": 1, "customerId": idstr, "status": false, "code":0, "branchId": Data.shared.branchid,"orderDetail": orderDetail]
            let token = UserDefaults.standard.value(forKey: SaveKey.access_token.toString()) as? String ?? ""
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            let urlrq:String = "http://52.77.233.77:8081/api/Order"
            AF.request(urlrq, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                KRProgressHUD.dismiss()
                switch response.result {
                case .success:
                    if let value = response.value {
                        if JSON(rawValue: value) != nil {
                            
                            Data.shared.oderProduct.removeAll()
                            self.tbMain.reloadData()
                            Helper.alertOrderSucc(msg: "Order successful!", target: self)

                        }
                    }
                    
                    break
                case .failure(let error):
                    print(response)
                    print(error)
                }
                
            }
        }
        if Data.shared.oderProduct.count == 0 {
            Helper.alert(msg: "Please add product to this order", target: self)
        }else{
            if idstr == 0{
                Helper.alertLogin(msg: "Please log in!", target: self)
            }
        }
    }
    
    
    func confixData() -> Void {
        var arayProduct:[OrderProduct] = []
        var check:Bool = false
        for i in Data.shared.oderProduct {
            for j in arayProduct {
                if i.idProduct == j.idProduct{
                    j.SoLuong += i.SoLuong
                    check = true
                }
            }
            if check == false {
                arayProduct.append(i)
            }
            check = false
        }
        Data.shared.oderProduct = arayProduct
    }
    
    func toltalPrice() -> Int {
        var t : Int = 0
        for i in Data.shared.oderProduct {
            t += i.product.price * i.SoLuong
        }
        return t
    }
}

extension OrderVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lbTotalPrice.text = String(self.toltalPrice()) + " đ"
        return Data.shared.oderProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderCell
        cell.item = Data.shared.oderProduct[indexPath.row]
        cell.handle = {item in
            self.tbMain.reloadData()
        }
        cell.handleDelete = {item in
            Data.shared.oderProduct.remove(at: indexPath.row)
            self.tbMain.reloadData()
        }
        if !(Data.shared.oderProduct[indexPath.row].product.pictures.count <= 0){
            cell.imgProduct.kf.setImage(with: URL(string: Data.shared.oderProduct[indexPath.row].product.pictures[0].imageUrl), placeholder: UIImage(named: "noimage"), options: [], progressBlock: { (a, b) in
                
            }) { (result) in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension OrderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
