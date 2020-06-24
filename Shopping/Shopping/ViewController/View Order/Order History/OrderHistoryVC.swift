//
// OrderHistoryVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SwiftyJSON
class OrderHistoryVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    

    @IBOutlet weak var tbvListOrder: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Order History"
        tbvListOrder.register(UINib.init(nibName: "OHCell", bundle: nil), forCellReuseIdentifier: "OHCell")
        tbvListOrder.dataSource = self
        tbvListOrder.delegate = self
        tbvListOrder.separatorStyle = .none
        initUI()
        initData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
        initData()
    }

    @IBAction func actionBack(_ sender: Any) {
               let app = UIApplication.shared.delegate as! AppDelegate
               app.tabVC?.selectedIndex = 2
               self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.orderHistory.count
    }
    func setupNav() {
            let right = UIBarButtonItem(image: #imageLiteral(resourceName: "new_order").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showBranch))
            self.navigationItem.rightBarButtonItem = right
        }
        
        @objc func showBranch() {
            
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OHCell", for: indexPath as IndexPath) as! OHCell
        cell.lbDate.text = Data.shared.orderHistory[indexPath.row].orderDate.toString()
        cell.lbNuber.text = String(indexPath.row + 1)
        cell.lbStatus.text = String(Data.shared.orderHistory[indexPath.row].status)
        cell.lbTotalPrice.text = String(Data.shared.orderHistory[indexPath.row].totalPrice)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductByOrderVC(nibName: "ProductByOrderVC", bundle: nil)
        vc.vitri = Int( Data.shared.orderHistory[indexPath.row].id)
              let nav = UINavigationController(rootViewController: vc)
              nav.modalPresentationStyle = .fullScreen
              self.present(nav, animated: true, completion: nil)
    }

}
extension OrderHistoryVC{
    func initUI()  {
        
    }
    
    func initData(){
        let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
        AF.request("http://52.77.233.77:8081/api/Order/GetAllOrder?customerId=" + String(idstr) + "&status=true&page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                                                                        
                        Data.shared.orderHistory = []
                        for js in json["items"].arrayValue {
                            let oh = OrderHistory.init(json: js)
                            Data.shared.orderHistory.append(oh)
                            
                            
                        }
                        self.tbvListOrder.reloadData()
                        
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
