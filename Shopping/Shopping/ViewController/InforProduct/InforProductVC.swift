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
    //    @IBOutlet weak var lbSoLuong: UILabel!
    //    @IBOutlet weak var btTruSL: UIButton!
    @IBOutlet weak var clvImage: UICollectionView!
    @IBOutlet weak var lbDescription: UILabel!
    //    @IBOutlet weak var btCongSL: UIButton!
    
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var btCongSL: UIButton!
    @IBOutlet weak var btTruSL: UIButton!
    @IBOutlet weak var lbCongty: UILabel!
    
    var SoLuong:Int = 1
    var name:String = ""
    var price:String = ""
    var dicr:String = ""
    var vitri:Int = 0
    var Cty:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product"
        setupNav()
        lbDescription.text = dicr
        lbNameP.text = name
        lbPrive.text = price
        lbCongty.text = Cty
        if SoLuong == 1{
            btTruSL.isUserInteractionEnabled = false
        }
        clvImage.register(UINib.init(nibName: "InforProductCell", bundle: nil), forCellWithReuseIdentifier: "InforProductCell")
        clvImage.dataSource = self
        clvImage.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoLuong = 1
        lbSoLuong.text = String(SoLuong)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let i:Int = Data.shared.product[vitri].pictures.count
        if i == 0 {
            return 1
        }else{
            return i
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InforProductCell", for: indexPath as IndexPath) as! InforProductCell
        
        if Data.shared.product[vitri].pictures.count > 0 {
            cell.imgProduct.imageWithUrl(Data.shared.product[vitri].pictures[indexPath.row].imageUrl, placeholder: UIImage(named: "noimage"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wihth = view.frame.width - 10
        
        let height = (view.frame.height * 2 / 5) - 10
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
        let op:OrderProduct = OrderProduct()
        op.product = Data.shared.product[vitri]
        op.SoLuong = Int(lbSoLuong.text ?? "0")!
        op.idProduct = Data.shared.product[vitri].id
        Data.shared.oderProduct.append(op)
        
        
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
