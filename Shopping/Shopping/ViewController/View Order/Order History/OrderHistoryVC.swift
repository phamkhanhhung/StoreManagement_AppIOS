//
// OrderHistoryVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class OrderHistoryVC: UIViewController {
    
    @IBOutlet weak var tbvListOrder: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.tabVC?.selectedIndex = 2
        self.dismiss(animated: true, completion: nil)
    }
}
extension OrderHistoryVC{
    func initUI()  {
        title = "Order"
        setupNav()
        setupTableView()
    }
    
    func setupTableView() {
        tbvListOrder.register(UINib.init(nibName: "OHCell", bundle: nil), forCellReuseIdentifier: "OHCell")
        tbvListOrder.dataSource = self
        tbvListOrder.delegate = self
        tbvListOrder.separatorStyle = .none
        tbvListOrder.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        setupRefreshControl()
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.3882352941, alpha: 1)
        tbvListOrder.addSubview(refreshControl)
    }
    
    @objc func refresh()  {
        loadData()
    }
    
    func setupNav() {
        let right = UIBarButtonItem(image: #imageLiteral(resourceName: "order_add").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.addOrder))
        self.navigationItem.rightBarButtonItem = right
    }
    
    @objc func addOrder() {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        self.present(nav, animated: true, completion: nil)
    }
    
    func initData(){
        loadData()
    }
    
    func loadData()  {
        KRProgressHUD.show()
        let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
        if idstr != 0 {
            let token = UserDefaults.standard.value(forKey: SaveKey.access_token.toString()) as? String ?? ""
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            
            AF.request("http://52.77.233.77:8081/api/Order/GetAllOrder?customerId=" + String(idstr) + "&page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                KRProgressHUD.dismiss()
                switch response.result {
                case .success:
                    if let value = response.value {
                        if let json = JSON(rawValue: value) {
                            
                            Data.shared.orderHistory.removeAll()
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.refreshControl.endRefreshing()
                }
                
            }
        }
        
    }
}

extension OrderHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OHCell", for: indexPath as IndexPath) as! OHCell
        cell.configCell(order: Data.shared.orderHistory[indexPath.row])
        return cell
    }
}

extension OrderHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductByOrderVC(nibName: "ProductByOrderVC", bundle: nil)
        vc.vitri = Data.shared.orderHistory[indexPath.row].id
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}
