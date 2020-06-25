//
// OrderVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SwiftyJSON

class OrderVC: UIViewController , UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var total:Int = 0
    //    var arayProduct:[OrderProduct] = []
    
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var clvProduct: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Order"
        clvProduct.register(UINib.init(nibName: "OrderCell", bundle: nil), forCellWithReuseIdentifier: "OrderCell")
        clvProduct.dataSource = self
        clvProduct.delegate = self
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
        confixData()
        clvProduct.reloadData()
    }
    
    func setupNav() {
        let right = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showBranch))
        self.navigationItem.leftBarButtonItem = right
    }
    
    @objc func showBranch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOrder(_ sender: Any) {
        let idstr = UserDefaults.standard.value(forKey: SaveKey.idlogin.toString()) as? Int ?? 0
        if idstr != 0 && Data.shared.oderProduct.count > 0 {
            var orderDetail: [[String: Any]] = []
            for obj in Data.shared.oderProduct {
                let param: [String: Any] = ["quantity": obj.SoLuong, "disCount": 1, "productId": obj.product.id]
                orderDetail.append(param)
            }
            let parameters: [String:Any] = ["staffId": 1, "customerId": idstr, "status": false, "code":0,"orderDetail": orderDetail]
            let token = UserDefaults.standard.value(forKey: SaveKey.access_token.toString()) as? String ?? ""
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            let urlrq:String = "http://52.77.233.77:8081/api/Order"
            AF.request(urlrq, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                
                switch response.result {
                case .success:
                    if let value = response.value {
                        if let json = JSON(rawValue: value) {
                            
                            Data.shared.oderProduct.removeAll()
                            self.clvProduct.reloadData()
                            
                        }
                    }
                    
                    break
                case .failure(let error):
                    Data.shared.oderProduct.removeAll()
                    self.clvProduct.reloadData()
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.lbTotal.text = String( self.toltalPrice())
        return Data.shared.oderProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath as IndexPath) as! OrderCell
        cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        //cell.btTruSL.tag = indexPath.row
        //        cell.btTruSL.addTarget(self, action: #selector(self.actionTruSL(sennder:)), for: .touchUpInside)
        
        cell.item = Data.shared.oderProduct[indexPath.row]
        cell.handle = { item in
            //            self.lbTotal.text = String( self.toltalPrice())
            self.clvProduct.reloadData()
        }
        cell.handleDelete = { item in
            Data.shared.oderProduct.remove(at: indexPath.row)
            self.clvProduct.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wihth = (view.frame.width - 20)
        let height = wihth / 2
        return CGSize(width: wihth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
