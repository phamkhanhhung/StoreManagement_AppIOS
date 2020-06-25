//
// InforProductVC.swift.
// Shopping.
// 

import UIKit
import Kingfisher

class InforProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var imgProductView: UIImageView!
    @IBOutlet weak var lbNameP: UILabel!
    @IBOutlet weak var lbPrive: UILabel!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var btTruSL: UIButton!
    @IBOutlet weak var clvImage: UICollectionView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btCongSL: UIButton!
    
    var SoLuong:Int = 1
    var name:String = ""
    var price:String = ""
    var dicr:String = ""
    var vitri:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product"
        setupNav()
        lbDescription.text = dicr
        lbNameP.text = name
        lbPrive.text = price
        if SoLuong == 1{
            btTruSL.isUserInteractionEnabled = false
        }
        clvImage.register(UINib.init(nibName: "InforProductCell", bundle: nil), forCellWithReuseIdentifier: "InforProductCell")
        clvImage.dataSource = self
        clvImage.delegate = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func setupNav() {
            let right = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showBranch))
            self.navigationItem.leftBarButtonItem = right
        }
        
        @objc func showBranch() {
//            let app = UIApplication.shared.delegate as! AppDelegate
//            app.tabVC?.selectedIndex = 0
            navigationController?.popViewController(animated: true)
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let i:Int = Data.shared.product[vitri].pictures.count
        if i <= 0 {
            return 1
        }else{
            return i
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InforProductCell", for: indexPath as IndexPath) as! InforProductCell
//        cell.imgProduct.kf.setImage(with: URL(string: "https://d1zjrlgnm4bf8m.cloudfront.net/59ec3af2-edaf-4b5d-9472-44040a402e37?Expires=1592016966&Signature=Xe7R0vVPDiKf3UsdyoZHksjo9bO2CnqSQuqLU1~ISGiFWs2VNQoDqu8wCpYu9qgpF8RnGOA6CT3wMeNZ6UFTkBgdlIpFS~grlUhdjezMxAXH-HtlLzmeXDzsezmOXvcQXLOJ5xaI~pg0CGgdoyFd3yNLETJZNY9RKX-bGYPdLKJ2oUptlTRuboMQFc4vDc2WaPdfD5BCINWbt~zxMRee36Au3aBTHHGzsjvhCQ6bH1W7nUoX2-zLdiuLJRuBXtsbNaEGAyacfugA~kefYiuZ8WYYSSRJrgQ0sjw35yM9rbAnIPfbyXKRlXF~sBWoq4OUJHNzlu1WVsna7tuF04m9Cw__&Key-Pair-Id=APKAIIO7MT3ZQL3H45GA"))
        if !(Data.shared.product[vitri].pictures.count <= 0){
            cell.imgProduct.kf.setImage(with: URL(string: Data.shared.product[vitri].pictures[indexPath.row].imageUrl), placeholder: UIImage(named: "noimage"), options: [], progressBlock: { (a, b) in
                
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wihth = view.frame.width - 10
        
        let height = view.frame.height * 2 / 5
        return CGSize(width: wihth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    @IBAction func actionTruSL(_ sender: Any) {
        SoLuong-=1
        lbSoLuong.text = String(SoLuong)
        if SoLuong == 1{
            btTruSL.isUserInteractionEnabled = false
        }
    }
    @IBAction func actionCongSL(_ sender: Any) {
        SoLuong+=1
        btTruSL.isUserInteractionEnabled = true
        lbSoLuong.text = String(SoLuong)
    }
    
    
    @IBAction func actionAddToCart(_ sender: Any) {
//        let del = UIApplication.shared.delegate as! AppDelegate
//        del.vBag.isHidden = false
        let op:OrderProduct = OrderProduct()
        op.product = Data.shared.product[vitri]
        op.SoLuong = Int(lbSoLuong.text ?? "0")!
        op.idProduct = Data.shared.product[vitri].id
        Data.shared.oderProduct.append(op)
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        vc.p = true
              let nav = UINavigationController(rootViewController: vc)
              nav.modalPresentationStyle = .fullScreen
       
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let app = UIApplication.shared.delegate as! AppDelegate
//        app.tabVC?.selectedIndex = 1
//        self.dismiss(animated: true, completion: nil)
        
    }
    
}
