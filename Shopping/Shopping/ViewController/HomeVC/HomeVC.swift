//
// HomeVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var clvProduct: UICollectionView!
    @IBOutlet weak var tbvChooses: UITableView!
    
    @IBOutlet weak var lbSearch: UISearchBar!
    
    
    let cellReuseIdentifier = "cell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clvProduct.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        clvProduct.dataSource = self
        clvProduct.delegate = self
        
        
        
        tbvChooses.register(UINib.init(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tbvChooses.dataSource = self
        tbvChooses.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initData()
        initUI() 
    }
    
    @IBAction func actionChooses(_ sender: Any) {
        if tbvChooses.isHidden {
            tbvChooses.isHidden = false
        }else{
            tbvChooses.isHidden = true
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.branch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tbCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath as IndexPath) as! HomeTableCell
        tbCell.lbSTT.text = String(indexPath.row + 1)
        tbCell.lbAddress.text = String( Data.shared.branch[indexPath.row].address)
        tbCell.lbPhoneNuber.text = String( Data.shared.branch[indexPath.row].phoneNumber)
        tbCell.lbDescription.text = String( Data.shared.branch[indexPath.row].description0)
        return tbCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tbvChooses.isHidden = true
        Data.shared.product = []
        self.clvProduct.reloadData()
        let id:Int = Data.shared.branch[indexPath.row].id
        AF.request("http://52.77.233.77:8081/api/Product/GetAllProductInBranch?BranchId=" + String(id) + "&page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                        let total = json["total"].intValue
                        Data.shared.totalProduct = total
                        
                        for js in json["items"].arrayValue {
                            let pro = Product.init(json: js)
                            Data.shared.product.append(pro)
                            
                        }
                        self.clvProduct.reloadData()
                        
                    }
                }
                
                break
            case .failure(let error):
                
                print(response)
                print(error)
            }
            
        }
    }
    
    
    func getProduct()  {
        
    }
    
    //CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.shared.product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath as IndexPath) as! HomeCell
        let str:String = Data.shared.product[indexPath.row ].categoryName + " " + Data.shared.product[indexPath.row].name
        cell.lbNameProduct.text = String(str)
        cell.lbSupplierName.text = String( Data.shared.product[indexPath.row ].supplierName)
        cell.lbPrice.text = String( Data.shared.product[indexPath.row ].price)
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        if !(Data.shared.product[indexPath.row].pictures.count <= 0){
            cell.imgProduct.kf.setImage(with: URL(string: Data.shared.product[indexPath.row].pictures[0].imageUrl), placeholder: UIImage(named: "noimage"), options: [], progressBlock: { (a, b) in
                
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = (view.frame.width-30)/2
        let height = width*4/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InforProductVC(nibName: "InforProductVC", bundle: nil)
        
        let str1:String = Data.shared.product[indexPath.row ].categoryName + " " + Data.shared.product[indexPath.row].name
        vc.name = str1
        vc.price = String( Data.shared.product[indexPath.row].price)
        vc.dicr = Data.shared.product[indexPath.row].description0
        vc.vitri = indexPath.row
        let nav = UINavigationController(rootViewController: vc)
        collectionView.deselectItem(at: indexPath, animated: true)
        self.present(nav, animated: true, completion: nil)
    }
    
    
}

extension HomeVC{
    func initUI()  {
        
    }
    
    func initData(){
        Data.shared.branch = []
        AF.request("http://52.77.233.77:8081/api/Branch?page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                        
                        
                        let branch = Branch(json: json["items"])
                        
                        for js in json["items"].arrayValue {
                            let pro = Branch.init(json: js)
                            Data.shared.branch.append(pro)
                            
                            self.tbvChooses.reloadData()
                        }
                        
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
