//
// ProductByOrderVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
class ProductByOrderVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    

    var vitri:Int = 0
    @IBOutlet weak var tbvProductBO: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvProductBO.register(UINib.init(nibName: "PBOCell", bundle: nil), forCellReuseIdentifier: "PBOCell")
        tbvProductBO.dataSource = self
        tbvProductBO.delegate = self
        tbvProductBO.separatorStyle = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
        initData()
    }

    @IBAction func actionBack(_ sender: Any) {
        Data.shared.listProductInOrder.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.listProductInOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PBOCell", for: indexPath as IndexPath) as! PBOCell
        cell.lbName.text = String( Data.shared.listProductInOrder[indexPath.row].productName)
        cell.lbPrice.text = String( Data.shared.listProductInOrder[indexPath.row].price)
        cell.lbQuantity.text = String(Data.shared.listProductInOrder[indexPath.row].quantity)
        if !(Data.shared.listProductInOrder[indexPath.row].picture.count <= 0){
                   cell.imgProduct.kf.setImage(with: URL(string: Data.shared.listProductInOrder[indexPath.row].picture[0].imageUrl), placeholder: UIImage(named: "noimage"), options: [], progressBlock: { (a, b) in
                       
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
extension ProductByOrderVC{
    func initUI()  {
        
    }
    
    func initData(){
        KRProgressHUD.show()
        AF.request("http://52.77.233.77:8081/api/OrderDetail?OrderId=" + String(vitri) + "&page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            KRProgressHUD.dismiss()
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                                                                        
                        Data.shared.listProductInOrder = []
                        for js in json["items"].arrayValue {
                            let oh = ListProductInOrder.init(json: js)
                            Data.shared.listProductInOrder.append(oh)
                            
                            
                        }
                        self.tbvProductBO.reloadData()
                        
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

